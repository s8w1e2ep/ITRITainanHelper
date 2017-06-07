//
//  NewViewController.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/11.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var wvHtml: UIWebView!
    
    
    var Hottitle: String! = "Titel"
    var content: String! = "Surprise! I'm back."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.Label.numberOfLines = 0;
        self.Label.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.Label.text = Hottitle
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
