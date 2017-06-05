//
//  NavigationMapViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 6/4/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import NitigationKit


class NavigationMapViewController: UIViewController, NavigationMapListener {

    @IBOutlet weak var navigationMapMap: UINavigationMap!
    var adminUnit = AdministrativeUnit()
    // check is navigation or position
    var isNavigation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationMapMap.navigationMapListener = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onInstructionUpdate(_ instruction: Instruction, result: String!) {
        print(result)
    }

    func onMapStatus(_ status: NavigationMapStatus) {
        print(status)
        if (status == NAVIGATION_DOCUMENT_LOADED) {
            if (self.isNavigation == true) {
                self.navigationMapMap.setTarget(self.adminUnit.fieldId, x: Int(self.adminUnit.x), y: Int(self.adminUnit.y), nearByPathId: self.adminUnit.nearByPathId)
                self.navigationMapMap.startNavigation()
            } else {
                self.navigationMapMap.setTarget(self.adminUnit.fieldId, x: Int(self.adminUnit.x), y: Int(self.adminUnit.y))
                self.navigationMapMap.startPositioning()
            }
        }
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
