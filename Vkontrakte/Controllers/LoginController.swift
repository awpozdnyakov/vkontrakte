//
//  LoginController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 15.12.2022.
//

import UIKit
import WebKit



final class LoginController: UIViewController {
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: config)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        loadAuth()
    }
}

// MARK: - WKNavigationDelegate
extension LoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
            
        if let token = params["access_token"], let id = params["user_id"] {
            Session.shared.userID = Int(id)!
            Session.shared.token = token
            print("-----------")
            print(token)
            print("-----------")
            decisionHandler(.cancel)
            performSegue(withIdentifier: "Login", sender: nil)
            
        }
    }
    
}

private extension LoginController {
    func configureWebView() {
        navigationController?.navigationBar.isHidden = true
        webView.navigationDelegate = self
    }
    
    func loadAuth() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "51505701"),
            URLQueryItem(name: "display ", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
