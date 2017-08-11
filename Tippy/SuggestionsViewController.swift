//
//  SuggestionsViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/10/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class SuggestionsViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureWebView()
        loadAddressURL()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // hide the activity indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - Convenience
    
    func loadAddressURL() {
        let url = URL(string: "http://money.cnn.com/pf/features/lists/tipping/")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }

    // MARK: - Configuration
    
    func configureWebView() {
        webView.backgroundColor = UIColor.white
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
    }
    
    // MARK - UIWebViewDelegate
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        // report the error inside the web view
        
        let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
        
        // create an error HTML page
        let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"
        
        webView.loadHTMLString(errorHTML, baseURL: nil)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
