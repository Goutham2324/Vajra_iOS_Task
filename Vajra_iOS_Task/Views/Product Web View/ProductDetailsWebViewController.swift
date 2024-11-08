//
//  ProductDetailsWebViewController.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation
import WebKit

class ProductDetailsWebViewController : UIViewController {
    
    private var webView: WKWebView!
    var bodyHTML: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadHTMLContent()
    }
    
    private func setupWebView() {
        webView = WKWebView(frame: self.view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
    }
    
    private func loadHTMLContent() {
        guard let htmlContent = bodyHTML else { return }
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
}
