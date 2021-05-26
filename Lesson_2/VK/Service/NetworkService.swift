//
//  NetworkService.swift
//  VK
//
//  Created by Сергей Зайцев on 26.05.2021.
//

import Foundation
import Alamofire


final class NetworkService {
    
    private let apiVersion = "5.130"
    
    private func makeComponents(for path: NetworkPaths) -> URLComponents {
        let urlComponent: URLComponents = {
            var url = URLComponents()
            url.scheme = "https"
            url.host = "api.vk.com"
            url.path = "/method/\(path.rawValue)"
            url.queryItems = [
                URLQueryItem(name: "access_token", value: UserSession.instance.token),
                URLQueryItem(name: "v", value: apiVersion),
            ]
            return url
        }()
        return urlComponent
    }
    
    func getUserFriends() {
        var urlComponents = makeComponents(for: .getFriends)
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "fields", value: "photo_200"),
        ])
            let session = URLSession(configuration: URLSessionConfiguration.default)
                if let url = urlComponents.url {
                    session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    print(try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
                }
            }
            .resume()
        }
        
        
    } 
}

