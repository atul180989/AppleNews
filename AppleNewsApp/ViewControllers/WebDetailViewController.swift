//
//  WebDetailViewController.swift
//  AppleNewsApp
//
//  Created by Atul Bhaisare on 6/5/20.
//  Copyright © 2020 Atul Bhaisare. All rights reserved.
//

import UIKit
import WebKit

class WebDetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var url: String?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        webView.navigationDelegate = self
        guard let url = URL(string: self.url ?? "") else { return }
        let request  = URLRequest(url: url)
        self.webView.load(request)
    }
}

//MARK: - WKNavigationDelegate
extension WebDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
 
