//
//  NewsDetailViewController.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/10.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var svContent: UIScrollView!
    var lbContent = UILabel()
    
    var content: String! = "Surprise! I'm back."
    var overlay = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attrStr = try! NSAttributedString(
            data: content.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        
        lbContent.frame = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.frame.size.width, height: view.frame.size.height)
        lbContent.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
        lbContent.textColor = UIColor.black
        lbContent.numberOfLines = 0
        lbContent.lineBreakMode = .byTruncatingTail
        lbContent.attributedText = attrStr
        svContent.addSubview(lbContent)
    }
    
    func viewDidApear (_ animated: Bool) {
        super.viewDidAppear(animated)
        lbContent.frame = svContent.bounds
        svContent.contentSize = lbContent.frame.size
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        lbContent.contentScaleFactor = scale
        lbContent.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.frame.size.width / scale, height: lbContent.frame.size.height)
        lbContent.contentMode = .scaleAspectFit
        svContent.contentSize = CGSize(width: lbContent.frame.size.width, height: (lbContent.frame.origin.y + lbContent.frame.size.height) * scale)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return lbContent
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
