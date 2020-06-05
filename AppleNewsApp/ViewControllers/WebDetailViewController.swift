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
    var url: String?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: self.url ?? "") else { return }
        let request  = URLRequest(url: url)
        self.webView.load(request)
    }
}
