//
//  VKService.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import Foundation
import RealmSwift

final class VKService {
    
    let session = Session.shared
    
    enum Method {
        case friends
        case photos(id: Int)
        case groups
        case searchGroups(text: String)
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .photos:
                return "/method/photos.getAll"
            case .groups:
                return "/method/groups.get"
            case .searchGroups:
                return "/method/groups.search"
            }
        }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return ["fields": "photo_50"]
            case let .photos(id):
                return ["owner_id": "\(id)"]
            case .groups:
                return ["extended": "1"]
            case let .searchGroups(text):
                return ["q": text]
            }
        }
    }

    // MARK: - Public
    
    func request<T: Decodable>(_ method: Method,
                               _ type: T.Type,
                               completion: (([T]) -> Void)? = nil) {
        request(method) { (data) in
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(VKResponse<T>.self, from: data)
                if let objects = response.items as? [Object] {
                    self.saveToRealm(objects, method: method)
                }
                completion?(response.items)
            } catch {
                print("VKService error: \(error.localizedDescription)")
                completion?([])
            }
        }
    }
    
    // MARK: -
    
    private func request(_ method: Method,
                         completion: @escaping ( (Data?) -> Void)) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.path
        let queryItems = [
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.68")
        ]
        let methodQueryItems = method.parameters.map { URLQueryItem(name: $0, value: $1) }
        components.queryItems = queryItems + methodQueryItems
        
        guard let url = components.url else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("VKService error: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        
        task.resume()
    }
    private func saveToRealm<T: Object> (_ objects: [T], method: Method) {
        do {
           let realm = try Realm()
            
            try realm.write {
                if case .photos(let id) = method {
                    objects
                        .map { $0 as? Photo }
                        .forEach { $0?.friendId = id }
                }
                realm.add(objects, update: .modified)
            }
        } catch  {
            print(error)
        }
    }
}
