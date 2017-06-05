//
//  ServiceViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/26/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ServiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var serviceTable: UITableView!
    
    var serviceDataArray = NSMutableArray()
    var databaseHelper = DatabaseHelper.init()
    var guideOverlay = UIView() // black frame
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // load data(only at init)
        self.databaseHelper = DatabaseHelper.init()
        // get all data
        self.serviceDataArray = self.databaseHelper.getAdministrativeCategories()
        self.serviceTable.delegate = self
        self.serviceTable.dataSource = self
        //Navigation layout
        let defaults = UserDefaults.standard
        let isMessageLaunchBefore = defaults.bool(forKey: "isMessageLaunchBefore")
        if isMessageLaunchBefore {
            /* normal layout */
        } else {
            /* first launch layout */
            setGuideLayout()
            defaults.set(true, forKey: "isMessageLaunchBefore")
        }
        
    }
    // set Navigation layout
    func setGuideLayout() {
        // set button
        let btnCheck: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 210, height: 73))
        btnCheck.setTitle("確定", for: .normal)
        btnCheck.setTitleColor(UIColor.white, for: .normal)
        btnCheck.isEnabled = true
        btnCheck.setBackgroundImage(UIImage(named: "instruction_button.png"), for: .normal)
        btnCheck.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.2)
        btnCheck.addTarget(self, action: #selector(NavigationViewController.checkClick), for: .touchUpInside)
        // set label
        let lbGuide: UILabel = UILabel()
        lbGuide.bounds = CGRect(x: view.frame.size.width * 0.4 - 40, y: view.frame.size.height * 0.5 - 125, width: 80, height: 250)
        lbGuide.center = CGPoint(x: view.frame.size.width * 0.4, y: view.frame.size.height * 0.5)
        lbGuide.text = "上\n下\n滑\n動\n以\n瀏\n覽\n內\n容"
        lbGuide.textColor = UIColor.white
        lbGuide.numberOfLines = 0
        lbGuide.lineBreakMode = .byWordWrapping
        lbGuide.font = UIFont.systemFont(ofSize: 18)
        // set image
        let imgHand: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 207, height: 255))
        imgHand.image = UIImage(named: "up_down_hand.png")
        imgHand.center = CGPoint(x: view.frame.size.width * 0.7, y: view.frame.size.height * 0.7)
        // set guideOverlay
        guideOverlay.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        guideOverlay.center = self.view.center
        guideOverlay.backgroundColor = UIColor(white: 0.0, alpha: 0.9)
        // add component to view
        guideOverlay.addSubview(btnCheck)
        guideOverlay.addSubview(lbGuide)
        guideOverlay.addSubview(imgHand)
        view.addSubview(guideOverlay)
    }
    
    func checkClick() {
        self.guideOverlay.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let categoryItem = self.serviceDataArray.object(at: indexPath.row) as! AdministrativeUnitCategory
        tableCell.textLabel?.text = categoryItem.name
        return tableCell
    //  return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
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
