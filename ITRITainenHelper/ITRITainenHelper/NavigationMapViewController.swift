//
//  NavigationMapViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 6/4/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import NitigationKit


class NavigationMapViewController: UIViewController, NavigationMapListener, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var navigationMapMap: UINavigationMap!
    var currentAdminUnit = AdministrativeUnit()
    // check is navigation or position
    var isNavigation = false
    var mapInstructionView = UIView()
    var currentFieldMap = FieldMap()
    var infoButton = UIButton()
    var plusButton = UIButton()
    var minusButton = UIButton()
    var compassImage = UIImageView()
    var bottomView = UIView()
    var bottomTitle = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationMapMap.navigationMapListener = self;

        // instruction flag & layout
        let defaults = UserDefaults.standard
        let isMapLaunchBefore = defaults.bool(forKey: "isMapLaunchBefore")
        if !isMapLaunchBefore {
            /* first launch layout */
            layoutInstructionViews()
            defaults.set(true, forKey: "isMapLaunchBefore")
        }
        
        let syncer = DataSyncer.getInstance()
        self.currentFieldMap = syncer?.getFieldMap(byId: self.currentAdminUnit.fieldId) as! FieldMap
        
        // Do any additional setup after loading the view.
        // all set ups
        initializeMap()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        stopBleService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.currentFieldMap.fieldName.characters.count != 0) {
            self.bottomTitle.text = self.currentFieldMap.fieldName
        } else {
            self.bottomTitle.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopBleService() {
        self.navigationMapMap.stopBLEScan()
    }
    
    func startBleService() {
        self.navigationMapMap.startBLEScan()
    }
    
    func layoutInstructionViews() {
        self.mapInstructionView.frame = self.view.bounds
        // alpha 0.5 black
        self.mapInstructionView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // dialog
        let dialogView = UIImageView()
        dialogView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height * 0.3)
        dialogView.image = UIImage(named: "instruction_dialog1.png")
        dialogView.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.6)
        
        // dialog text
        let dialogText = UILabel()
        dialogText.frame = CGRect(x: dialogView.bounds.origin.x + (dialogView.bounds.size.width*0.1), y: dialogView.bounds.origin.y + (dialogView.bounds.size.height*0.2), width: dialogView.bounds.size.width * 9/10, height: dialogView.bounds.size.height/2)
        dialogText.text = Constants.INSTRUCTION_MAP_INFO
        
        dialogText.lineBreakMode = .byWordWrapping
        dialogText.numberOfLines = 0
        
        // add text label to imageview
        dialogView.addSubview(dialogText)
        dialogView.bringSubview(toFront: dialogText)
        
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.center = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height * 0.4)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        // add button event
        nextButton.addTarget(self, action: #selector(instructionEventLast(sender:)), for: .touchUpInside)
        nextButton.setTitle("確定", for: .normal)
        
        // add all subview
        self.mapInstructionView.addSubview(dialogView)
        self.mapInstructionView.addSubview(nextButton)
        self.mapInstructionView.bringSubview(toFront: dialogView)
        self.mapInstructionView.bringSubview(toFront: nextButton)
        
        // add the welcome subview
        self.view.addSubview(self.mapInstructionView)
        self.view.bringSubview(toFront: self.mapInstructionView)
    }
    
    /*
     * initialize all components in this Map Controller
     */
    func initializeMap() {
        // layout compass imageView
        self.compassImage.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width/8, height: self.view.bounds.size.height/10)
        self.compassImage.image = UIImage(named: "compass1.png")
        
        // layout plus button and minus button
        self.plusButton.frame = CGRect(x: self.view.bounds.origin.x + 2, y: self.view.bounds.origin.y + 2, width: self.view.bounds.size.width/12, height: self.view.bounds.size.height/12)
        self.plusButton.setImage(UIImage(named: "zoom_in.png"), for: .normal)
        self.plusButton.addTarget(self, action: #selector(self.zoomIn), for: .touchUpInside)
        
        self.minusButton.frame = CGRect(x: self.view.bounds.origin.x + 2, y: self.view.bounds.origin.y + self.view.bounds.size.height/12 + 4, width: self.view.bounds.size.width/12, height: self.view.bounds.size.height/12)
        self.minusButton.addTarget(self, action: #selector(self.zoomOut), for: .touchUpInside)
        self.minusButton.setImage(UIImage(named: "zoom_out.png"), for: .normal)
        
        // set bottom view
        self.bottomView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y + self.view.bounds.size.height*9/10, width: self.view.bounds.size.width, height: self.view.bounds.size.height/10)
        self.bottomView.backgroundColor = UIColor.init(red: 248.0/250.0, green: 85.0/255.0, blue: 28.0/255.0, alpha: 1)
        
        // add bottom title
        self.bottomTitle.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/4, y: self.view.bounds.origin.y + self.view.bounds.size.height*9/10, width: self.view.bounds.size.width/2, height: self.view.bounds.size.height/10)
        self.bottomTitle.textAlignment = .center
        self.bottomTitle.backgroundColor = UIColor.clear
        self.bottomTitle.textColor = UIColor.white
        self.bottomTitle.text = self.currentFieldMap.fieldName
        
        // add bottom button
        self.infoButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/4, y: self.view.bounds.origin.y + self.view.bounds.size.height*9/10, width: self.view.bounds.size.width/10, height: self.view.bounds.size.height/10)
        self.infoButton.setImage(UIImage(named: "info.png"), for: .normal)
        self.infoButton.addTarget(self, action: #selector(self.displayMapDetail(sender:)), for: .touchUpInside)
        
        // bring to front
        self.bottomView.addSubview(self.bottomTitle)
        self.bottomView.addSubview(self.infoButton)
        self.bottomView.bringSubview(toFront: self.bottomTitle)
        self.bottomView.bringSubview(toFront: self.infoButton)
        
        // add all subview
        self.view.addSubview(self.compassImage)
        self.view.addSubview(self.plusButton)
        self.view.addSubview(self.minusButton)
        self.view.addSubview(self.bottomView)
        self.view.bringSubview(toFront: self.compassImage)
        self.view.bringSubview(toFront: self.plusButton)
        self.view.bringSubview(toFront: self.minusButton)
        self.view.bringSubview(toFront: self.bottomView)
    }
    
    func instructionEventLast(sender: UIButton) {
        self.mapInstructionView.removeFromSuperview()
    }
    
    // zoom in
    func zoomIn() {
        
    }
    
    // zoom out
    func zoomOut() {
        
    }
    
    func displayMapDetail(sender: UIButton) {
        // display uialert view controller as action sheet
        let currentName = self.currentAdminUnit.name!
        let currentMessage = self.currentAdminUnit.description!
        let titleString = "\(currentName)(\(self.currentFieldMap.fieldName))"
        let messageString = "\(currentMessage)"
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle: .actionSheet)
        var actionText = String()
        if (self.isNavigation == false) {
            actionText = "顯示位置"
            self.isNavigation = true
        } else {
            actionText = "進行導覽"
        }
        let confirmAction = UIAlertAction(title: actionText, style: .default, handler: { (action) -> Void in
            // do navigating / positioning by checking
            self.executeFunction()
        })
        alertController.addAction(confirmAction)
    }
    
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func onInstructionUpdate(_ instruction: Instruction, result: String!) {
        print(result)
    }
    
    func executeFunction() {
        if (self.isNavigation) {
            startNavigation()
        } else {
            showAdministrativeLocation()
        }
    }

    func startNavigation() {
        self.navigationMapMap.setTarget(self.currentAdminUnit.fieldId, x: Int(self.currentAdminUnit.x), y: Int(self.currentAdminUnit.y), nearByPathId: self.currentAdminUnit.nearByPathId)
        self.navigationMapMap.startNavigation()
        startBleService()
    }
    
    func showAdministrativeLocation() {
        stopBleService()
        self.navigationMapMap.stopNavigation()
        self.navigationMapMap.setTarget(self.currentAdminUnit.fieldId, x: Int(self.currentAdminUnit.x), y: Int(self.currentAdminUnit.y), nearByPathId: self.currentAdminUnit.nearByPathId)
        self.navigationMapMap.show(self.currentAdminUnit.fieldId)
        self.navigationMapMap.showTarget(at: Int(self.currentAdminUnit.x), y: Int(self.currentAdminUnit.y))
    }
    
    func onMapStatus(_ status: NavigationMapStatus) {
        print(status)
//        if (status == NAVIGATION_DOCUMENT_LOADED) {
//            if (self.isNavigation == true) {
//                self.navigationMapMap.setTarget(self.currentAdminUnit.fieldId, x: Int(self.currentAdminUnit.x), y: Int(self.currentAdminUnit.y), nearByPathId: self.currentAdminUnit.nearByPathId)
//                self.navigationMapMap.startNavigation()
//            } else {
//                self.navigationMapMap.setTarget(self.currentAdminUnit.fieldId, x: Int(self.currentAdminUnit.x), y: Int(self.currentAdminUnit.y))
//                self.navigationMapMap.startPositioning()
//            }
//        }
        if (status == NAVIGATION_MAP_LOADED) {
            self.bottomTitle.text = self.navigationMapMap.getCurrentLoadedFieldName()
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
