//
//  NavigationViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/26/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationTableView: UITableView!
    @IBOutlet weak var navigationSearchBar: UISearchBar!
    var navigationDataArray = NSMutableArray()
    var databaseHelper = DatabaseHelper.init()
    var guideOverlay = UIView() // black frame
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationDataArray.add("yes")
        // Do any additional setup after loading the view.
        
        // load data(only at init)
        self.databaseHelper = DatabaseHelper.init()
        // get all data
        self.navigationDataArray = self.databaseHelper.getAdministrativeCategories()
        self.navigationTableView.delegate = self
        self.navigationTableView.dataSource = self
        //Navigation layout
        let defaults = UserDefaults.standard
        let isMessageLaunchBefore = defaults.bool(forKey: "isMessageLaunchBefore")
        if isMessageLaunchBefore {
            /* normal layout */
        } else {
            /* first launch layout */
            setGuideLayout()
            //defaults.set(true, forKey: "isMessageLaunchBefore")
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
        // should go back to main storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateInitialViewController()!
//        self.present(controller, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let categoryItem = self.navigationDataArray.object(at: indexPath.row) as! AdministrativeUnitCategory
        tableCell.textLabel?.text = categoryItem.name
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.navigationDataArray.count
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if (segue.identifier == "dashboardDetailVC") {
//            let detailVC = segue.destination
//            
//        }
        let destinationViewController = segue.destination as! NavigationDetailViewController
        let indexPath = self.navigationTableView.indexPathForSelectedRow
        let selectedRow = indexPath?.row
        let category = self.navigationDataArray.object(at: selectedRow!) as! AdministrativeUnitCategory
        destinationViewController.categoryId = category.categoryId!
    }
    

}
