//
//  VKServiceNews.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 14.07.2021.
//

import Foundation
import VK_ios_sdk

protocol VKServiceDelegate: VKSdkUIDelegate {
    func authorizationFinished()
}

enum VKServiceError: Error {
    case nilComponents
    case nilUrl
    case noData
    case noResponse
    case connectionError(error: Error)
    case httpError(code: Int)
    case jsonSerialization(error: Error)
}
final class VKServiceNews: NSObject {
    
    var userId: String?
    private let appID = "7863898"
    private let scope = ["wall", "friends"]
    private let apiString = "https://api.vk.com/method/"
    private let apiVersion = "5.131"
    private var sdkInstance: VKSdk?
    private var accessToken: String?
    private var delegate: VKServiceDelegate?
    
    func setup (with delegate: VKServiceDelegate) {
        self.delegate = delegate
        sdkInstance = VKSdk.initialize(withAppId: appID)
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = delegate
        VKSdk.wakeUpSession(scope) { (state, error) in
            if state == .authorized {
                delegate.authorizationFinished()
            } else {
                VKSdk.authorize(self.scope)
            }
        }
    }
    
    @discardableResult
    func get(with methodName: String, params: [(name: String, value: String)]?, completion:@escaping (Any?, Error?) -> Void) -> URLSessionDataTask? {
        func raiseError(_ error: Error) {
            completion(nil, error)
        }
        guard var components = URLComponents(string: "\(apiString)\(methodName)") else {
            raiseError(VKServiceError.nilComponents);
            return nil
        }
        var items = [
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "v", value: apiVersion)
        ]
        if let params = params {
            for param in params {
                items.append(URLQueryItem(name: param.name, value: param.value))
            }
        }
        components.queryItems = items
        guard let url = components.url else {
            raiseError(VKServiceError.nilUrl);
            return nil
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if let error = error {
                    raiseError(VKServiceError.connectionError(error: error))
                    return;
                }
                if 200...299 ~= httpResponse.statusCode {
                    guard let data = data else {
                        raiseError(VKServiceError.noData)
                        return;
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with:data, options: [])
                        completion(json, nil)
                    } catch let jsonError {
                        raiseError(VKServiceError.jsonSerialization(error: jsonError))
                    }
                } else {
                    raiseError(VKServiceError.httpError(code: httpResponse.statusCode))
                }
            } else {
                raiseError(VKServiceError.noResponse)
            }
        }
        task.resume()
        return task
    }
}

extension VKServiceNews: VKSdkDelegate {
    
    func vkSdkAccessTokenUpdated(_ newToken: VKAccessToken!, oldToken: VKAccessToken!) {
        if newToken != nil {
            accessToken = newToken.accessToken
            userId = newToken.userId
        }
    }
    
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
        if result.state == .authorized {
            delegate?.authorizationFinished()
         } else {
        }
    }
    
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken!) {
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result == nil {
            return
        }
        if result.token != nil {
            accessToken = result.token.accessToken
            userId = result.token.userId
        } else {
        }
        if result.state == .authorized {
            delegate?.authorizationFinished()
        } else {
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
    }
}

