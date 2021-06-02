//
//  LoginViewController.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 30.05.2021.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {

    let session = Session.shared

    // MARK: - Outlets

    @IBOutlet weak var webView: WKWebView!


    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

//        removeCookies()
        webView.navigationDelegate = self
        loadVKAuth()
    }

    func loadVKAuth() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7863898"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "336918"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = components.url else { return }

        let request = URLRequest(url: url)
        webView.load(request)
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
            else {
                decisionHandler(.allow)
                return
        }

        let parameters = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, parameter in
                var dict = result
                dict.updateValue(parameter[1], forKey: parameter[0])
                return dict
        }

        if let userId = parameters["user_id"], let token = parameters["access_token"] {
            session.token = token
            session.userId = userId
            performSegue(withIdentifier: "HomeSegue", sender: nil)
        } else {
            print("No access token found!")
        }

        decisionHandler(.cancel)
    }
}
    // MARK: - Чистим кэш

    func removeCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})

            }
        }
    }



