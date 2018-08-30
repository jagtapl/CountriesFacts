//
//  DetailViewController.swift
//  CountriesFacts
//
//  Created by LALIT JAGTAP on 7/30/18.
//  Copyright © 2018 LALIT JAGTAP. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard detailItem != nil else { return }
        
        if let name = detailItem["name"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> name { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += name
            html += "<h1>"
            html += "Capital = "
            html += detailItem["capital"]!
            html += "</h1>"
            html += "<h2>"
            html += "Population = "
            html += detailItem["population"]!
            html += "</h2>"
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
            
            title = "Country = " + name
        }
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
