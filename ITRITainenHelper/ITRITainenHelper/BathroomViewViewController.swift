//
//  BathroomViewViewController.swift
//  testyu
//
//  Created by uscc on 2017/4/19.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class BathroomViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
<<<<<<< HEAD
    var passarray = [String]()
    var info = [String]()
    var guideOverlay = UIView() // black frame
    var isFirst = false
    //var vc:String?

=======
    var list = [String]()
    // welcome view
    var firstWelcomeView = UIView()
    var secondWelcomeView = UIView()
    var thirdWelcomeView = UIView()
    var welcomeInstructinView = UIView()
>>>>>>> 610832dfe8f92fad7ef8158b26ba96e822276f0b
    @IBOutlet weak var mytable: UITableView!
    //var info = ["1樓東側廁所","1樓西側廁所","2樓東側廁所","2樓西側廁所","3樓東側廁所","3樓西側廁所","4樓東側廁所","4樓西側廁所","5樓東側廁所","5樓西側廁所","6樓東側廁所","6樓西側廁所","7樓東側廁所","7樓西側廁所","8樓東側廁所","8樓西側廁所","9樓東側廁所","9樓西側廁所","10樓東側廁所","10樓西側廁所","11樓東側廁所","11樓西側廁所","12樓東側廁所","12樓西側廁所","13樓廁所","14樓廁所","15樓廁所","16樓廁所"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let defaults = UserDefaults.standard
        let checkFirstLaunch = defaults.bool(forKey: "isAppFirstLaunch")
        if (checkFirstLaunch == true) {
            // is first launch
            isFirst = true
            setGuideLayout()
        }*/

        /*mytable.register(
            UITableViewCell.self, forCellReuseIdentifier: "Cell")
 */
        let defaults = UserDefaults.standard
        let isFacilityLaunchBefore = defaults.bool(forKey: "isFacilityLaunchBefore")
        if isFacilityLaunchBefore {
            /* normal layout */
            
        } else {
            /* first launch layout */
            // TODO: - do something
            layoutInstructionViews()
            //defaults.set(true, forKey: "isFacilityLaunchBefore")
            
        }


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - layout instruction subviews
    func layoutWelcomeLayoutOne() {
        self.firstWelcomeView.frame = self.view.bounds
        // alpha 0.5 black
        self.firstWelcomeView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // dialog
        let dialogView = UIImageView()
        dialogView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height * 0.4)
        dialogView.image = UIImage(named: "instruction_dialog.png")
        dialogView.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.3)
        
        // dialog text
        let dialogText = UILabel()
        dialogText.frame = CGRect(x: dialogView.bounds.origin.x + (dialogView.bounds.size.width*0.05), y: dialogView.bounds.origin.y + (dialogView.bounds.size.height*0.23), width: dialogView.bounds.size.width * 9/10, height: dialogView.bounds.size.height/2)
        dialogText.text = Constants.INSTRUCTION_MAP_POSITIONING
        
        dialogText.lineBreakMode = .byWordWrapping
        dialogText.numberOfLines = 0
        
        // add text label to imageview
        dialogView.addSubview(dialogText)
        dialogView.bringSubview(toFront: dialogText)
        
        // image
        let personImageView = UIImageView()
        personImageView.frame = CGRect(x: self.view.bounds.origin.x+(self.view.bounds.size.width*0.1), y: self.view.bounds.origin.y + (self.view.bounds.size.height*0.5), width: self.view.bounds.size.width*0.35, height: self.view.bounds.size.height/3)
        personImageView.image = UIImage(named: "instructor1.png")
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.center = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height * 0.9)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        // add button event
        nextButton.addTarget(self, action: #selector(instructionEventOne(sender:)), for: .touchUpInside)
        nextButton.setTitle("下一步", for: .normal)
        
        // add all subview
        self.firstWelcomeView.addSubview(dialogView)
        self.firstWelcomeView.addSubview(personImageView)
        self.firstWelcomeView.addSubview(nextButton)
        self.firstWelcomeView.bringSubview(toFront: dialogView)
        self.firstWelcomeView.bringSubview(toFront: personImageView)
        self.firstWelcomeView.bringSubview(toFront: nextButton)
        
        // add the welcome subview
        self.view.addSubview(self.firstWelcomeView)
        self.view.bringSubview(toFront: self.firstWelcomeView)
    }
    
    func layoutWelcomeLayoutTwo() {
        self.secondWelcomeView.frame = self.view.bounds
        // alpha 0.5 black
        self.secondWelcomeView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // dialog
        let dialogView = UIImageView()
        dialogView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height * 0.4)
        dialogView.image = UIImage(named: "instruction_dialog.png")
        dialogView.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.3)
        
        // dialog text
        let dialogText = UILabel()
        dialogText.frame = CGRect(x: dialogView.bounds.origin.x + (dialogView.bounds.size.width*0.05), y: dialogView.bounds.origin.y + (dialogView.bounds.size.height*0.23), width: dialogView.bounds.size.width * 9/10, height: dialogView.bounds.size.height/2)
        dialogText.text = Constants.INSTRUCTION_MAP_NAVIGATING
        
        dialogText.lineBreakMode = .byWordWrapping
        dialogText.numberOfLines = 0
        
        // add text label to imageview
        dialogView.addSubview(dialogText)
        dialogView.bringSubview(toFront: dialogText)
        
        // image
        let personImageView = UIImageView()
        personImageView.frame = CGRect(x: self.view.bounds.origin.x+(self.view.bounds.size.width*0.1), y: self.view.bounds.origin.y + (self.view.bounds.size.height*0.5), width: self.view.bounds.size.width*0.35, height: self.view.bounds.size.height/3)
        personImageView.image = UIImage(named: "instructor1.png")
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.center = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height * 0.9)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        // add button event
        nextButton.addTarget(self, action: #selector(instructionEventTwo(sender:)), for: .touchUpInside)
        nextButton.setTitle("確認", for: .normal)
        
        // add all subview
        self.secondWelcomeView.addSubview(dialogView)
        self.secondWelcomeView.addSubview(personImageView)
        self.secondWelcomeView.addSubview(nextButton)
        self.secondWelcomeView.bringSubview(toFront: dialogView)
        self.secondWelcomeView.bringSubview(toFront: personImageView)
        self.secondWelcomeView.bringSubview(toFront: nextButton)
        
        // add the welcome subview
        self.view.addSubview(self.secondWelcomeView)
        self.view.bringSubview(toFront: self.secondWelcomeView)
    }
    
    // 上下滑動以瀏覽內容？
    func layoutInstructionViews() {
        self.welcomeInstructinView.frame = self.view.bounds
        self.welcomeInstructinView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let fingerView = UIImageView()
        fingerView.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width*0.4, y: self.view.bounds.origin.y + self.view.bounds.size.height/3, width: self.view.bounds.size.width/2, height: self.view.bounds.height/3)
        fingerView.image = UIImage(named: "up_down_hand.png")
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.center = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height * 0.9)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        nextButton.addTarget(self, action: #selector(instructionEventFinger(sender:)), for: .touchUpInside)
        nextButton.setTitle("下一步", for: UIControlState.normal)
        // set label
        let lbGuide: UILabel = UILabel()
        lbGuide.bounds = CGRect(x: view.frame.size.width * 0.4 - 40, y: view.frame.size.height * 0.5 - 125, width: 80, height: 250)
        lbGuide.center = CGPoint(x: view.frame.size.width * 0.4, y: view.frame.size.height * 0.5)
        lbGuide.text = "上\n下\n滑\n動\n以\n瀏\n覽\n內\n容"
        lbGuide.textColor = UIColor.white
        lbGuide.numberOfLines = 0
        lbGuide.lineBreakMode = .byWordWrapping
        lbGuide.font = UIFont.systemFont(ofSize: 18)
        
        self.welcomeInstructinView.addSubview(fingerView)
        self.welcomeInstructinView.addSubview(nextButton)
        self.welcomeInstructinView.addSubview(lbGuide)
        self.welcomeInstructinView.bringSubview(toFront: fingerView)
        self.welcomeInstructinView.bringSubview(toFront: nextButton)
        self.welcomeInstructinView.bringSubview(toFront: lbGuide)
        
        self.view.addSubview(welcomeInstructinView)
        self.view.bringSubview(toFront: welcomeInstructinView)
    }
    
    // instruction button events
    func instructionEventFinger(sender: UIButton) {
        self.welcomeInstructinView.removeFromSuperview()
        layoutWelcomeLayoutOne()
    }
    
    func instructionEventOne(sender: UIButton) {
        self.firstWelcomeView.removeFromSuperview()
        // load second instruction view
        layoutWelcomeLayoutTwo()
    }
    
    func instructionEventTwo(sender: UIButton) {
        self.secondWelcomeView.removeFromSuperview()
        // load second instruction view
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
        
    // 必須實作的方法：每一組有幾個 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! Bathroomcell
        //cell.img.text = "\(indexPath.row)"
        cell.textlabel.text = info[indexPath.row]
        //let imgname = indexPath.row % 2 == 0 ?"close.png":"1.png"
        cell.img.image = UIImage(named: indexPath.row % 2 == 0 ?"index_logo1.png":"govenment_128.png")
        
        /*if indexPath.row % 2 == 0{
            cell.img.image = UIImage(named: "close.png")
        }
        else{
            cell.img.image = UIImage(named: "1.png")
        }*/

        //cell.btn1.numberOfLines = 0;
        //cell.btn2.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
        return cell
    }

    
    /*
    // 必須實作的方法：每個 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as UITableViewCell
        
        
        
     
        // 設置 Accessory 按鈕樣式
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.accessoryType = .checkmark
            } else if indexPath.row == 1 {
                cell.accessoryType = .detailButton
            } else if indexPath.row == 2 {
                cell.accessoryType = .detailDisclosureButton
            } else if indexPath.row == 3 {
                cell.accessoryType = .disclosureIndicator
            }
        }
        
        // 顯示的內容
        if let myLabel = cell.textLabel {
            myLabel.text = "\(info[indexPath.row])"
        }
     
        return cell
    }
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
