//
//  EdmDetailViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 6/4/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class EdmDetailViewController: UIViewController {

    @IBOutlet weak var edmDetailWebView: UIWebView!
    var edmURL = String()
    
    @IBAction func goBackAction(_ sender: Any) {
        // dismiss current view
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let url = URL(string: self.edmURL)
        let requestObj = URLRequest(url: url!)
        
        self.edmDetailWebView.loadRequest(requestObj)
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
