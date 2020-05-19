//
//  WebViewController.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 14/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class WebViewController: BaseFile, WKNavigationDelegate {

    @IBOutlet weak var activity: UIActivityIndicatorView?
    @IBOutlet weak var webView: WKWebView?
    public var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView?.navigationDelegate  = self
        webView?.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let stringUrl = self.url {
            let url = URL(string: stringUrl)!
            webView?.load(URLRequest(url: url))
        }
         
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.activity?.startAnimating()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activity?.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Error from webView \(error)")
        let alert = UIAlertController(title: "Error", message: "Unable to laod content.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
