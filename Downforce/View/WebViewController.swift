//
//  WebViewController.swift
//  Downforce
//
//  Created by Ayush Bhople on 25/04/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var url: String?
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: url ?? "https://www.apple.com")
        let request = URLRequest(url: myURL!)
        webView.load(request)
        
    }
}
