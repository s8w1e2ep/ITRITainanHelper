//
//  NewsDetailViewController.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/10.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController, UIWebViewDelegate {
    

    @IBOutlet weak var wvHtml: UIWebView!
    
    var content: String! = "Surprise! I'm back."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wvHtml.loadHTMLString(content, baseURL: nil)
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
