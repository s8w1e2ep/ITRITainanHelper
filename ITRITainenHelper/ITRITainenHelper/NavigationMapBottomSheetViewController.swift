//
//  NavigationMapBottomSheetViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 6/5/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import NitigationKit

class NavigationMapBottomSheetViewController: UIViewController {

    
    
    var popOverAdminUnit = AdministrativeUnit()
    var fieldMap = FieldMap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height*2/5)
        // get filedMap data
//        let syncer = DataSyncer.getInstance()
//        self.fieldMap = syncer?.getFieldMap(byId: self.popOverAdminUnit.fieldId) as! FieldMap
        
        // layout buttons
        layoutPopOver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutPopOver() {
        let titleAndFieldName = UILabel(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + 5, width: self.preferredContentSize.width * 3/4, height: self.preferredContentSize.height/2))
        titleAndFieldName.text = "\(String(describing: self.popOverAdminUnit.name))(\(self.fieldMap.fieldName))"
        
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
