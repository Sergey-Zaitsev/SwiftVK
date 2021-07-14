//
//  NewsService.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 14.07.2021.
//

import Foundation

enum NewsfeedServiceError: Error {
    case modelParsing
    case noPostsResponse
}

final class NewsfeedService {
    let vkServiceNews: VKServiceNews
    weak var previousRequest: URLSessionDataTask?
    
    init(vkService: VKServiceNews) {
        self.vkServiceNews = vkService
    }
    
    func get(from: String? = nil, completion:@escaping ([Post], String?, Bool, Error?) -> Void) {
        var params =  [(name: "source_ids", value: "friends,groups,pages"),
                       (name: "filters", value: "post"),
                       (name: "count", value: "20")
        ]
        if let startFrom = from {
            params.append((name: "start_from", value: startFrom))
        }
        previousRequest?.cancel()
        previousRequest = vkServiceNews.get(with: "newsfeed.get", params: params, completion: { [weak self] (data, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion([], nil, from != nil, error)
                }
            } else {
                let response = self?.parseJSON(json: data)
                DispatchQueue.main.async {
                    if let error = response?.error {
                        completion([], nil, from != nil, error)
                    } else if let posts = response?.posts {
                        completion(posts, response?.nextFrom, from != nil, nil)
                    } else {
                        completion([], nil, from != nil, NewsfeedServiceError.noPostsResponse)
                    }
                }
            }
        })
    }
}

// MARK: - response parsing, model mapping

private extension NewsfeedService {
    
    func parseJSON(json: Any?) -> (posts: [Post], nextFrom: String?, error: Error?) {
        guard let dict = json as? [String : Any], let response = dict["response"] as? [String: Any] else {
            return ([], nil, NewsfeedServiceError.modelParsing)
        }
        guard let items = response["items"] as? [[String: Any]] else {
            return ([], nil, NewsfeedServiceError.modelParsing)
        }
        var profiles = [Int: Profile]()
        if let profilesJson = response["profiles"] as? [[String: Any]] {
            for item in profilesJson {
                let profileResponse = ProfileParser.parse(profileJSON: item)
                if let profile = profileResponse.profile, profileResponse.error == nil {
                    profiles[profile.id] = profile
                }
            }
        }
        var groups = [Int: GroupNews]()
        if let groupsJson = response["groups"] as? [[String: Any]] {
            for item in groupsJson {
                let groupsResponse = GroupParser.parse(groupJSON: item)
                if let group = groupsResponse.group, groupsResponse.error == nil {
                    groups[group.id] = group
                }
            }
        }
        var posts = [Post]()
        for item in items {
            let postResponse = PostParser.parse(postJson: item, profiles: profiles, groups: groups)
            if let error = postResponse.error {
                return ([], nil, error)
            } else if let post = postResponse.post {
                posts.append(post)
            }
        }
        let nextFrom = response["next_from"] as? String
        return (posts, nextFrom, nil)
    }
}
