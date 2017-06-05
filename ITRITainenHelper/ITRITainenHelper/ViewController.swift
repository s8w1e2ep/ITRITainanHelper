//
//  ViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/16/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import SQLite
import NitigationKit
import SwiftyJSON
import AVKit
import AVFoundation


class ViewController: UIViewController, DataSyncerListener, NavigationMapListener, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    // activity view: has to add image as bg
    @IBOutlet weak var activityView: UIView!
    var activityImageView =  UIImageView()
    @IBOutlet weak var functionCollection: UICollectionView!
    weak var navigationBar: UINavigationBar!
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    var rightActivityButton =  UIButton()
    var leftActivityButton = UIButton()
    
    var cellBgImage: UIImage!
    var titleCombineView: UIView!
    var checkFunction: Int = 0
    var databaseHelper: DatabaseHelper!
    
    // image arrays
    var logoImage: [UIImage] = [
        UIImage(named: "demo1.png")!,
        UIImage(named: "activities.png")!,
        UIImage(named: "news.png")!
    ]
    var logoImageCount: Int = 0
    var webviewString = [String]()
    var maxImageCount: Int = 0
    // layer
    let welcomeLayer = CALayer()
    // syncing views and flags
    var isSyncComplete = false
    let syncingView = UIView()
    // AVPlayer
    let playerUrl = Bundle.main.url(forResource: "video", withExtension: "mp4")!
    var playerLayer = AVPlayerLayer()
    var player = AVPlayer()
    // welcome view
    var firstWelcomeView = UIView()
    var secondWelcomeView = UIView()
    var thirdWelcomeView = UIView()
    var welcomeInstructinView = UIView()
    var edmArray = NSMutableArray()
    var selectedEdm = Edm()
    

    //MARK: - basic functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // database initialization
        self.databaseHelper = DatabaseHelper.init(name: "test_1.sqlite")
        self.databaseHelper.createDB()
        
        // SQLITE: - download pictures and data
        syncAllTables()
        
        /* syncing always goes first */
        // add syncing comparison
        /*
        if self.isSyncComplete == false {
            self.syncingView.frame = self.view.bounds
            self.syncingView.backgroundColor = UIColor.black
            
            // AVPlayer set up
            let playerItem = AVPlayerItem(url: self.playerUrl)
            self.player = AVPlayer(playerItem: playerItem)
            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer.frame = self.view.bounds
            
            let downloadingLabel = UILabel(frame: CGRect(x: self.syncingView.bounds.origin.x + self.syncingView.bounds.size.width/5, y: self.syncingView.bounds.origin.y + self.syncingView.bounds.size.height * 13/14, width: self.syncingView.bounds.size.width * 3/5, height: self.syncingView.bounds.size.height/14))
            downloadingLabel.text = Constants.DATA_STATUS_SYNC
            downloadingLabel.backgroundColor = UIColor.clear
            downloadingLabel.textColor = UIColor.white
            self.syncingView.layer.addSublayer(self.playerLayer)
            self.syncingView.addSubview(downloadingLabel)
            self.view.addSubview(self.syncingView)
            // 開始播放
            self.player.play()
        }
        */
        
        //main layout
        let defaults = UserDefaults.standard
        let isAppLaunchBefore = defaults.bool(forKey: "isAppLaunchBefore")
        if isAppLaunchBefore {
            /* normal layout */

        } else {
            /* first launch layout */
            // TODO: - do something
            layoutWelcomeLayoutOne()
            //defaults.set(true, forKey: "isAppLaunchBefore")

        }
        
        /* get data from edm table and set swipe image */
        /*self.edmArray = self.databaseHelper.queryEdmTable()
        let edmImageArray = NSMutableArray()
        for edms in self.edmArray {
            let edmItem = edms as! Edm
            print(edmItem)
            let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(edmItem.edmImage!)
            do {
                if try !url.checkResourceIsReachable() {
                    // if file does not exist, download file
                    DataSyncer.downloadFile("\(url)", destination: "\(url)")
                } else {
                    let image = UIImage(contentsOfFile: edmItem.edmImage!)t
                    edmImageArray.add(image!)
                }
            } catch _ {
                print("cannot find file: \(url)")
            }
        }
        
        // set up image array & count, type cast
        self.logoImage = edmImageArray as! [UIImage]
        self.logoImageCount = self.logoImage.count
        */
        
        /////// TEST: - test function here
        //        let temp_array = databaseHelper.testQueryCategoryId(rank: Int64(DatabaseHelper.KEYWORD_ADMINISTRATIVE_CATEGORY_RANK))
        //        let aray = databaseHelper.queryAdministrativeUnitByCategoryId(categoryId: "adminUnitCate_570b6ff3994e52_62953457")
        //        print("query unit category with rank: \(temp_array)")
        //        print("query unit by category id: \(aray)")
        
        self.navigationBar = UINavigationBar.appearance()
        self.navigationItem.hidesBackButton = false
        
        // add left and right button to activityView
        self.rightActivityButton = UIButton.init(frame: CGRect(x: self.activityView.bounds.origin.x + self.activityView.bounds.size.width/12*9.5, y: self.activityView.bounds.origin.y + self.activityView.bounds.size.height/2, width: self.activityView.bounds.size.width/12, height: self.activityView.bounds.size.width/12))
        self.rightActivityButton.setImage(UIImage.init(named: "index_right.png"), for: UIControlState.normal)
        self.leftActivityButton = UIButton.init(frame: CGRect(x: self.activityView.bounds.origin.x + self.activityView.bounds.size.width/12*1.5, y: self.activityView.bounds.origin.y + self.activityView.bounds.size.height/2, width: self.activityView.bounds.size.width/12, height: self.activityView.bounds.size.width/12))
        self.leftActivityButton.setImage(UIImage.init(named: "index_left.png"), for: UIControlState.normal)
        
        // initialize iamge view
//        self.activityImageView = UIImageView.init(frame: self.activityView.bounds)
        
        // TODO: - navigation bar/item layout is not good, needed to be fixed
        // put image to title bar
//        print(self.myNavigationItem.title!)
//        self.myNavigationItem.titleView = UIView.init(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.height/12.5))
//        let logo = UIImage.init(named: "index_logo1.png")
//        let logoImageView = UIImageView.init(frame: CGRect(x: self.navigationItem.titleView!.bounds.origin.x, y: self.navigationItem.titleView!.bounds.origin.y, width: self.navigationItem.titleView!.bounds.size.width * 1/5, height: self.navigationItem.titleView!.bounds.size.height))
//        let logoLabel = UILabel.init(frame: CGRect(x: self.navigationItem.titleView!.bounds.origin.x + self.navigationItem.titleView!.bounds.width/5, y: self.navigationItem.titleView!.bounds.origin.y, width: self.navigationItem.titleView!.bounds.size.width * 4/5, height: self.navigationItem.titleView!.bounds.size.height))
//        logoImageView.image = logo
//        logoLabel.text = Constants.MAIN_BAR_TITLE
//        self.myNavigationItem.titleView!.addSubview(logoImageView)
//        self.myNavigationItem.titleView!.addSubview(logoLabel)
//        self.myNavigationItem.titleView!.bringSubview(toFront: logoImageView)
//        self.myNavigationItem.titleView!.bringSubview(toFront: logoLabel)
//        self.myNavigationItem.titleView!.backgroundColor = UIColor.init(red: 60, green: 176, blue: 157, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // get maximum images to display for imageView
        self.maxImageCount = self.logoImage.count
        
        // swipe handling
        self.activityView.isUserInteractionEnabled = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.activityView.addGestureRecognizer(swipeRight)
        self.activityView.addGestureRecognizer(swipeLeft)
        
        let pageTap = UITapGestureRecognizer(target: self, action: #selector(self.handlePageTap(sender:)))
        self.activityView.addGestureRecognizer(pageTap)
        
        // add target
        self.rightActivityButton.addTarget(self, action: #selector(ViewController.rightActivitySwitch), for: UIControlEvents.allTouchEvents)
        self.leftActivityButton.addTarget(self, action: #selector(ViewController.leftActivitySwitch), for: UIControlEvents.allTouchEvents)
        
        // image view initialization
        self.activityImageView.frame = self.activityView.bounds;
        self.activityImageView.image = self.logoImage[0]
        
        self.activityView.addSubview(self.activityImageView)
        self.activityView.bringSubview(toFront: self.activityImageView)
        
        // add button subview
        self.activityView.addSubview(self.rightActivityButton)
        self.activityView.addSubview(self.leftActivityButton)
        self.activityView.bringSubview(toFront: self.rightActivityButton)
        self.activityView.bringSubview(toFront: self.leftActivityButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - layout instruction subviews
    func layoutWelcomeLayoutOne() {
        self.firstWelcomeView.frame = self.view.bounds
        // alpha 0.9 black
        self.firstWelcomeView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    
        // dialog
        let dialogView = UIImageView()
        dialogView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height * 0.5)
        dialogView.image = UIImage(named: "instruction_dialog.png")
        dialogView.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.3)
        
        // dialog text
        let dialogText = UILabel()
        dialogText.frame = CGRect(x: dialogView.bounds.origin.x + (dialogView.bounds.size.width*0.05), y: dialogView.bounds.origin.y + (dialogView.bounds.size.height*0.15), width: dialogView.bounds.size.width * 9/10, height: dialogView.bounds.size.height/2)
        dialogText.text = Constants.INSTRUCTION_WELCOME_1
        dialogText.textAlignment = .center
        dialogText.lineBreakMode = .byWordWrapping
        dialogText.numberOfLines = 0
        
        // add text label to imageview
        dialogView.addSubview(dialogText)
        dialogView.bringSubview(toFront: dialogText)
        
        // image
        let personImageView = UIImageView()
        personImageView.frame = CGRect(x: self.view.bounds.origin.x + (self.view.bounds.size.width*0.05), y: self.view.bounds.origin.y + (self.view.bounds.size.height*0.55), width: self.view.bounds.size.width*0.35, height: self.view.bounds.size.height*0.3)
        personImageView.image = UIImage(named: "instructor.png")
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.center = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height * 0.8)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        // add button event
        nextButton.addTarget(self, action: #selector(instructionEventOne(sender:)), for: .touchUpInside)
        nextButton.setTitle("下一步", for: .normal)
        nextButton.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.9)
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
        // alpha 0.9 black
        self.secondWelcomeView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // dialog
        let dialogView = UIImageView()
        dialogView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height * 0.5)
        dialogView.image = UIImage(named: "instruction_dialog1.png")
        dialogView.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.3)
        
        // dialog text
        let dialogText = UILabel()
        dialogText.frame = CGRect(x: dialogView.bounds.origin.x + (dialogView.bounds.size.width*0.05), y: dialogView.bounds.origin.y + (dialogView.bounds.size.height*0.15), width: dialogView.bounds.size.width * 9/10, height: dialogView.bounds.size.height/2)
        dialogText.text = Constants.INSTRUCTION_WELCOME_2
        dialogText.textAlignment = .center
        dialogText.lineBreakMode = .byWordWrapping
        dialogText.numberOfLines = 0
        
        // add text label to imageview
        dialogView.addSubview(dialogText)
        dialogView.bringSubview(toFront: dialogText)
        
        // image
        let personImageView = UIImageView()
        personImageView.frame = CGRect(x: self.view.bounds.origin.x + (self.view.bounds.size.width*0.65), y: self.view.bounds.origin.y + (self.view.bounds.size.height*0.55), width: self.view.bounds.size.width*0.3, height: self.view.bounds.size.height*0.3)
        personImageView.image = UIImage(named: "instructor1.png")
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.center = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height * 0.8)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        // add button event
        nextButton.addTarget(self, action: #selector(instructionEventTwo(sender:)), for: .touchUpInside)
        nextButton.setTitle("下一步", for: .normal)
        nextButton.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.9)
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
    
    func layoutWelcomeLayoutThird() {
        self.thirdWelcomeView.frame = self.view.bounds
        // alpha 0.9 black
        self.thirdWelcomeView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        // dialog
        let dialogView = UIImageView()
        dialogView.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height * 0.5)
        dialogView.image = UIImage(named: "instruction_dialog2.png")
        dialogView.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.3)
        
        // dialog text
        let dialogText = UILabel()
        dialogText.frame = CGRect(x: dialogView.bounds.origin.x + (dialogView.bounds.size.width*0.05), y: dialogView.bounds.origin.y + (dialogView.bounds.size.height*0.15), width: dialogView.bounds.size.width * 9/10, height: dialogView.bounds.size.height/2)
        dialogText.text = Constants.INSTRUCTION_WELCOME_3
        dialogText.textAlignment = .center
        dialogText.lineBreakMode = .byWordWrapping
        dialogText.numberOfLines = 0
        
        // add text label to imageview
        dialogView.addSubview(dialogText)
        dialogView.bringSubview(toFront: dialogText)
        
        // image
        let personImageView = UIImageView()
        personImageView.frame = CGRect(x: self.view.bounds.origin.x + (self.view.bounds.size.width*0.05), y: self.view.bounds.origin.y + (self.view.bounds.size.height*0.55), width: self.view.bounds.size.width*0.35, height: self.view.bounds.size.height*0.3)
        personImageView.image = UIImage(named: "instructor.png")

        let personImageView1 = UIImageView()
        personImageView1.frame = CGRect(x: self.view.bounds.origin.x + (self.view.bounds.size.width*0.65), y: self.view.bounds.origin.y + (self.view.bounds.size.height*0.55), width: self.view.bounds.size.width*0.3, height: self.view.bounds.size.height*0.3)
        personImageView1.image = UIImage(named: "instructor1.png")
        
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.center = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height * 0.8)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        // add button event
        nextButton.addTarget(self, action: #selector(instructionEventThree(sender:)), for: .touchUpInside)
        nextButton.setTitle("確定", for: .normal)
        nextButton.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.9)
        // add all subview
        
        self.thirdWelcomeView.addSubview(dialogView)
        self.thirdWelcomeView.addSubview(personImageView)
        self.thirdWelcomeView.addSubview(personImageView1)
        self.thirdWelcomeView.addSubview(nextButton)
        
        self.thirdWelcomeView.bringSubview(toFront: dialogView)
        self.thirdWelcomeView.bringSubview(toFront: personImageView)
        self.thirdWelcomeView.bringSubview(toFront: personImageView1)
        self.thirdWelcomeView.bringSubview(toFront: nextButton)
        
        // add the welcome subview
        self.view.addSubview(self.thirdWelcomeView)
        self.view.bringSubview(toFront: self.thirdWelcomeView)    }
    
    // 左右滑動以瀏覽內容
    func layoutInstructionViews() {
        self.welcomeInstructinView.frame = self.view.bounds
        self.welcomeInstructinView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        let fingerView = UIImageView()
        fingerView.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/4, y: self.view.bounds.origin.y + self.view.bounds.size.height/3, width: self.view.bounds.size.width/2, height: self.view.bounds.height/3)
        fingerView.image = UIImage(named: "left_right_hand.png")
        // set label
        let lbGuide: UILabel = UILabel()
        lbGuide.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width*0.5, height: self.view.bounds.size.height/14)
        lbGuide.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.3)
        lbGuide.text = Constants.INSTRUCTION_LEFT_RIGHT_CONTENT
        lbGuide.textColor = UIColor.white
        lbGuide.numberOfLines = 0
        lbGuide.lineBreakMode = .byWordWrapping
        lbGuide.font = UIFont.systemFont(ofSize: 18)
        // button
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: self.view.bounds.origin.x + self.view.bounds.size.width/3, y: self.view.bounds.origin.y + (self.view.bounds.size.height*13/14), width: self.view.bounds.size.width/3, height: self.view.bounds.size.height/14)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button.png"), for: UIControlState.normal)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.selected)
        nextButton.setBackgroundImage(UIImage(named: "instruction_button_pressed.png"), for: UIControlState.highlighted)
        
        // event
        nextButton.addTarget(self, action: #selector(instructionEventLast(sender:)), for: .touchUpInside)
        nextButton.setTitle("確定", for: UIControlState.normal)
        nextButton.center = CGPoint(x: self.view.bounds.size.width / 2, y: view.frame.size.height * 0.9)
        self.welcomeInstructinView.addSubview(lbGuide)
        self.welcomeInstructinView.addSubview(fingerView)
        self.welcomeInstructinView.addSubview(nextButton)
        self.welcomeInstructinView.bringSubview(toFront: lbGuide)
        self.welcomeInstructinView.bringSubview(toFront: fingerView)
        self.welcomeInstructinView.bringSubview(toFront: nextButton)
        
        self.view.addSubview(welcomeInstructinView)
        self.view.bringSubview(toFront: welcomeInstructinView)
    }
    
    // instruction button events
    func instructionEventOne(sender: UIButton) {
        self.firstWelcomeView.removeFromSuperview()
        // load second instruction view
        layoutWelcomeLayoutTwo()
    }
    
    func instructionEventTwo(sender: UIButton) {
        self.secondWelcomeView.removeFromSuperview()
        // load second instruction view
        layoutWelcomeLayoutThird()
    }
    
    func instructionEventThree(sender: UIButton) {
        self.thirdWelcomeView.removeFromSuperview()
        // load second instruction view
        layoutInstructionViews()
    }
    
    func instructionEventLast(sender: UIButton) {
        self.welcomeInstructinView.removeFromSuperview()
    }
    
    //MARK: - swipe handler & tap handler on pageView
    
    // switch between imageviews
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        print("logo image count: ", self.logoImageCount)
        if (sender.direction == .left) {
            // swipe left
            print("left swipe")
            self.logoImageCount -= 1
            if (self.logoImageCount < 0) {
                print("count: \(self.logoImageCount)")
                self.logoImageCount = 0
                self.selectedEdm = self.edmArray.object(at: 0) as! Edm
            } else {
                // assign image to imageView
                UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromRight, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
                self.selectedEdm = self.edmArray.object(at: self.logoImageCount) as! Edm
            }
        } else if (sender.direction == .right) {
            // swipe right
            print("right swipe")
            self.logoImageCount += 1
            if (self.logoImageCount > self.maxImageCount - 1) {
                print("count: \(self.logoImageCount)")
                self.logoImageCount = self.maxImageCount - 1
                self.selectedEdm = self.edmArray.object(at: self.logoImageCount) as! Edm
            } else {
                // assign image to imageView
                UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromLeft, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
                self.selectedEdm = self.edmArray.object(at: self.logoImageCount) as! Edm
            }
        }
    }
    
    // MARK: - need to pass data to new view controller
    // tap handler on page view
    // always open new view controller if tapped the imageview
    func handlePageTap(sender: UITapGestureRecognizer) {
        // open view controller and push into view stack
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "edmViewController") as! EdmDetailViewController
        // current corresponding url
        controller.edmURL = self.selectedEdm.edmURL!
        self.present(controller, animated: true, completion: nil)
    }
    
    /* activity switch & handleswipes --> update selected edm */
    // switch to previous imageview
    func leftActivitySwitch() {
        self.logoImageCount -= 1
        if (self.logoImageCount < 0) {
            print("count: \(self.logoImageCount)")
            self.logoImageCount = 0
            // update selected edm
            self.selectedEdm = self.edmArray.object(at: 0) as! Edm
        } else {
            // assign image to imageView
            UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromRight, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
            // update selected edm
            self.selectedEdm = self.edmArray.object(at: self.logoImageCount) as! Edm
        }
    }
    
    // switch to next imageview
    func rightActivitySwitch() {
        self.logoImageCount += 1
        if (self.logoImageCount > self.maxImageCount - 1) {
            print("count: \(self.logoImageCount)")
            self.logoImageCount = self.maxImageCount - 1
            // update selected edm
            self.selectedEdm = self.edmArray.object(at: self.logoImageCount) as! Edm
        } else {
            // assign image to imageView
            UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromLeft, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
            // update selected edm
            self.selectedEdm = self.edmArray.object(at: self.logoImageCount) as! Edm
        }
    }
    
    
    //MARK: - collectionview delegate functions
    
    // uicollectionview delegate: 6 items in one section
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    // uicollectionviewcell: for every cell, add UIImageView and UILabel
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // configuration of cells
        if (indexPath.row == 0) {
            // get cell id and dequeue
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_one.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "市府訊息"
            textLabel.textAlignment = NSTextAlignment.center
            
            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_two.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "熱門活動"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "departmentCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_three.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "便民服務"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 3) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_four.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "局處導覽"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 4) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "navigateCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_five.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "市府設施"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else {
            // indexPath.row == 5
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_six.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "市府APP專區"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index: ", indexPath.row)
        if (indexPath.row == 0) {
            let storyboard = UIStoryboard(name: "Message", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 1) {
            self.checkFunction = 2
            let storyboard = UIStoryboard(name: "Activity", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 2) {
            self.checkFunction = 3
            let storyboard = UIStoryboard(name: "Service", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 3) {
            self.checkFunction = 4
            let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 4) {
            self.checkFunction = 5
            let storyboard = UIStoryboard(name: "Facility", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else {
            self.checkFunction = 6
            let storyboard = UIStoryboard(name: "Apps", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - insert data
    func insertData() {
        /* test databasehelper */
        let dbHelper = DatabaseHelper.init()
        dbHelper.createDB()
        
        /* test insert data into DatabaseHelper */
        // insert admin unit table
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 1, y: 1, fieldId: "fieldId_1", unitId: "1", parentUnitId: "parentUnitId_1", name: "name_1", tel: "06-11111111", fax: "06-11111112", email: "email_1@gmail.com", website: "http://www.administrativeUnit.com", description: "first data", iconName: "iconName_1", createTime: 1, lastUpdateTime: 1, nearByPathId: "nearByPathId_1", keyword: "keyword_1") {
            print("insert admin unit table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 2, y: 2, fieldId: "fieldId_2", unitId: "2", parentUnitId: "parentUnitId_2", name: "name_2", tel: "06-22222222", fax: "06-22222223", email: "email_2@gmail.com", website: "http://www.administrativeUnit.com/2", description: "data2", iconName: "iconName_2", createTime: 2, lastUpdateTime: 2, nearByPathId: "nearByPathId_2", keyword: "keyword_2") {
            print("insert admin unit table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 3, y: 3, fieldId: "fieldId_3", unitId: "3", parentUnitId: "parentUnitId_3", name: "name_3", tel: "06-33333333", fax: "06-33333334", email: "email_3@gmail.com", website: "http://www.administrativeUnit.com/3", description: "data3", iconName: "iconName_3", createTime: 3, lastUpdateTime: 3, nearByPathId: "nearByPathId_3", keyword: "keyword_3") {
            print("insert admin unit table success.")
        }
        
        // insert admin unit cat
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_1", name: "administrativeUnitCategory_1", description: "data_1", iconName: "iconName_1", createTime: 1, lastUpdateTime: 1, keyword: "keyword_1") {
            print("insert admin unit category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_2", name: "administrativeUnitCategory_2", description: "data_2", iconName: "iconName_2", createTime: 2, lastUpdateTime: 2, keyword: "keyword_2") {
            print("insert admin unit category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_3", name: "administrativeUnitCategory_3", description: "data_3", iconName: "iconName_3", createTime: 3, lastUpdateTime: 3, keyword: "keyword_3") {
            print("insert admin unit category table success.")
        }
        
        // unit in cat
        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_1", categoryId: "categoryId_1", lastUpdateTime: 1) {
            print("insert admin unit in category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_2", categoryId: "categoryId_2", lastUpdateTime: 2) {
            print("insert admin unit in category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_3", categoryId: "categoryId_3", lastUpdateTime: 3) {
            print("insert admin unit in category table success.")
        }
        
        // keyword table
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_1", keyword: "keyword_1", rank: 1, description: "keyword_table_1", createTime: 1, lastUpdateTime: 1) {
            print("insert keyword table success")
        }
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_2", keyword: "keyword_2", rank: 2, description: "keyword_table_2", createTime: 2, lastUpdateTime: 2) {
            print("insert keyword table success")
        }
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_3", keyword: "keyword_3", rank: 3, description: "keyword_table_3", createTime: 3, lastUpdateTime: 3) {
            print("insert keyword table success")
        }
        
        // in keyword
        if dbHelper.insertOrUpdateInKeywordTable(id: "1", keywordId: "keywordId_1", lastUpdateTime: 1) {
            print("insert in keyword table success")
        }
        if dbHelper.insertOrUpdateInKeywordTable(id: "2", keywordId: "keywordId_2", lastUpdateTime: 2) {
            print("insert in keyword table success")
        }
        if dbHelper.insertOrUpdateInKeywordTable(id: "3", keywordId: "keywordId_3", lastUpdateTime: 3) {
            print("insert in keyword table success")
        }
        
        // edm
        if dbHelper.insertOrUpdateEdmTable(edmId: "id1", edmName: "string", edmURL: "http://www.google.com", edmImage: "image.png", edmEndDay: "01/21/1111", lastUpdateTime: 1) {
            print("insert edm table success.")
        }
        if dbHelper.insertOrUpdateEdmTable(edmId: "id2", edmName: "string2", edmURL: "http://www.google.com/2", edmImage: "image2.png", edmEndDay: "01/21/1111", lastUpdateTime: 2) {
            print("insert edm table success.")
        }
        if dbHelper.insertOrUpdateEdmTable(edmId: "id3", edmName: "string3", edmURL: "http://www.google.com/3", edmImage: "image3.png", edmEndDay: "01/21/1111", lastUpdateTime: 3) {
            print("insert edm table success.")
        }
        
        // mobile app
//        if dbHelper.insertOrUpdateMobileAppTable(appId: "appId_1", appName: "app 1", appURL: "itunes.apple.com", appImage: "image.png", lastUpdateTime: 1) {
//            print("insert mobile app table success.")
//        }
//        if dbHelper.insertOrUpdateMobileAppTable(appId: "appId_2", appName: "app 2", appURL: "itunes.apple.com", appImage: "image2.png", lastUpdateTime: 2) {
//            print("insert mobile app table success.")
//        }
//        if dbHelper.insertOrUpdateMobileAppTable(appId: "appId_3", appName: "app 3", appURL: "itunes.apple.com", appImage: "image3.png", lastUpdateTime: 3) {
//            print("insert mobile app table success.")
//        }
        
        // query data example
        let admins = dbHelper.queryAdministrativeUnitTable()
        for admin in admins {
            let temp = admin as! AdministrativeUnit
            print(temp.x)
        }
    }
    
    func checkDataBase() {
//        let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("tainan3.sqlite")
        let url = Bundle.main.url(forResource: "tainan3", withExtension: "sqlite")!
        // Load the existing database
        if !FileManager.default.fileExists(atPath: url.path) {
            print("Not found, copy one!!!")
            let sourceSqliteURL = Bundle.main.url(forResource: "tainan3", withExtension: "sqlite")!
            print(sourceSqliteURL)
            print(url)
        }else{
            print("DB file exist")
        }
    }
    
    func readDataFromTainanSQLite() {
//         let dbURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("tainan2")
//        let path2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let path = Bundle.main.path(forResource: "tainan3", ofType: "sqlite")!
//        let tempDB = path + dbName
        let adminUnits = NSMutableArray()
        let adminUnitsCat = NSMutableArray()
        let adminUnitsInCat = NSMutableArray()
        let edms = NSMutableArray()
        let hots = NSMutableArray()
        let inKeys = NSMutableArray()
        let instructs = NSMutableArray()
        let keys = NSMutableArray()
        let mappings = NSMutableArray()
        let mobiles = NSMutableArray()

        do {
            // db connection to tainan.sqlite
            let db = try Connection(path)
            
            // define tables
            let adminUnitTable = Table("administrativeunit")
            let adminUnitCatTable = Table("administrativeunitcategory")
            let adminUnitInCatTable = Table("administrativeunitincategory")
            let edmTable = Table("edm")
            let hotTable = Table("hot")
            let inKeyTable = Table("inKeyword")
            let instructionTable = Table("instruction")
            let keywordTable = Table("keyword")
            let mappingKeyTable = Table("mappingKeyword")
            let mobileTable = Table("mobileApp")

            // query and store data
            for units in try db.prepare(adminUnitTable) {
                let temp = AdministrativeUnit(x: units[DBColExpressions.x], y: units[DBColExpressions.y], fieldId: units[DBColExpressions.fieldId], unitId: units[DBColExpressions.unitId], parentUnitId: units[DBColExpressions.parentUnitId], name: units[DBColExpressions.name], tel: units[DBColExpressions.tel], fax: units[DBColExpressions.fax], email: units[DBColExpressions.email], website: units[DBColExpressions.website], description: units[DBColExpressions.description], iconName: units[DBColExpressions.iconName], createTime: units[DBColExpressions.createTime], lastUpdateTime: units[DBColExpressions.lastUpdateTime], nearByPathId: units[DBColExpressions.nearByPathId], keyword: units[DBColExpressions.keyword])
                adminUnits.add(temp)
            }
            
            for cats in try db.prepare(adminUnitCatTable) {
                let temp = AdministrativeUnitCategory(categoryId: cats[DBColExpressions.categoryId], name: cats[DBColExpressions.name], description: cats[DBColExpressions.description], iconName: cats[DBColExpressions.iconName], createTime: cats[DBColExpressions.createTime], lastUpdateTime: cats[DBColExpressions.lastUpdateTime], keyword: cats[DBColExpressions.keyword])
                adminUnitsCat.add(temp)
            }
            
            for ins in try db.prepare(adminUnitInCatTable) {
                let temp = AdministrativeUnitInCategory(unitId: ins[DBColExpressions.unitId], categoryId: ins[DBColExpressions.categoryId], lastUpdateTime: ins[DBColExpressions.lastUpdateTime])
                adminUnitsInCat.add(temp)
            }
            
            for edmm in try db.prepare(edmTable) {
                let temp = Edm(edmId: edmm[DBColExpressions.edmId], edmName: edmm[DBColExpressions.edmName], edmURL: edmm[DBColExpressions.edmURL], edmImage: edmm[DBColExpressions.edmImage], edmEndDay: edmm[DBColExpressions.edmEndDay], lastUpdateTime: edmm[DBColExpressions.lastUpdateTime])
                edms.add(temp)
            }
            
            for hott in try db.prepare(hotTable) {
                let temp = HotItem(id: hott[DBColExpressions.id], hotDate: hott[DBColExpressions.hotDate], hotTitle: hott[DBColExpressions.hotTitle], hotDescription: hott[DBColExpressions.hotDescription], hotLink: hott[DBColExpressions.hotLink], isDelete: hott[DBColExpressions.isDelete])
                hots.add(temp)
            }
            
            for keys in try db.prepare(inKeyTable) {
                let temp = InKeywords(stringId: String(keys[DBColExpressions.stringId]), keywordId: keys[DBColExpressions.keywordId], lastUpdateTime: keys[DBColExpressions.wrongLastUpdateTime])
                inKeys.add(temp)
            }
            
            for instrs in try db.prepare(instructionTable) {
                let temp = InstructionItem(id: instrs[DBColExpressions.id], name: instrs[DBColExpressions.name], read: instrs[DBColExpressions.read])
                instructs.add(temp)
            }
            
            for k in try db.prepare(keywordTable) {
                let temp = Keyword(keywordId: k[DBColExpressions.keywordId], keyword: k[DBColExpressions.keyword], rank: k[DBColExpressions.rank], description: k[DBColExpressions.description], createTime: k[DBColExpressions.createTime], lastUpdateTime: k[DBColExpressions.lastUpdateTime])
                keys.add(temp)
            }
            
            for maps in try db.prepare(mappingKeyTable) {
                let temp = MappingKeyword(unitId: maps[DBColExpressions.unitId], keyword: maps[DBColExpressions.keyword])
                mappings.add(temp)
            }
            
            for mobs in try db.prepare(mobileTable) {
                let temp = MobileApps(appId: mobs[DBColExpressions.appId], appName: mobs[DBColExpressions.appName], appIOSUrl: mobs[DBColExpressions.appIOSUrl], appImage: mobs[DBColExpressions.appImage], lastUpdateTime: mobs[DBColExpressions.lastUpdateTime])
                mobiles.add(temp)
            }
        } catch _ {
            print("there is error.")
        }
        
        // print out all table data
        for data in adminUnits {
            let temp = data as! AdministrativeUnit
            print("administrative unit -> x: ", temp.x!, ", y: ", temp.y!, ", fieldId: ", temp.fieldId!, ", unitId: ", temp.unitId!, ", parentUnitId: ", temp.parentUnitId!, ", name: ", temp.name!, ", tel: ", temp.tel!, ", fax: ", temp.fax!, ", email: ", temp.email!, ", website: ", temp.website!, ", description: ", temp.description!, ", iconName: ", temp.iconName!, ", createTime: ", temp.createTime!, ", lastUpdateTime: ", temp.lastUpdateTime!, ", nearByPathId: ", temp.nearByPathId!, ", keyword: ", temp.keyword!)
        }
        
        for data in adminUnitsCat {
            let temp = data as! AdministrativeUnitCategory
            print("administrative unit category -> categoryId: ", temp.categoryId!, ", name: ", temp.name!, ", description: ", temp.description!, ", iconName: ", temp.iconName!, ", createTime: ", temp.createTime, ", lastUpdateTime: ", temp.lastUpdateTime, ", keyword: ", temp.keyword!)
        }
        
        for data in adminUnitsInCat {
            let temp = data as! AdministrativeUnitInCategory
            print("administrative unit in category -> unitId: ", temp.unitId!, ", categoryId: ", temp.categoryId!, ", lastUpdateTime: ", temp.lastUpdateTime!)
        }
        
//        for data in edms {
//            let temp = data as! Edm
//            print("edm -> edmId: ", temp.edmId!, ", edmName: ", temp.edmName!, ", edmURL: ", temp.edmURL!, ", edmImage: ", temp.edmImage!, ", edmEndDay: ", temp.edmEndDay!, ", lastUpdateTime: ", temp.lastUpdateTime!)
//        }
        
        for data in hots {
            let temp = data as! HotItem
            print("(", temp.id!, ", ", temp.hotDate!, ", ", temp.hotTitle!, ", ", temp.hotDescription!, ", ", temp.hotLink!, ", ", temp.isDelete!, ")")
        }
        
        for data in inKeys {
            let temp = data as! InKeywords
            print("(", temp.stringId!, ", ", temp.keywordId!, ", ", temp.lastUpdateTime!, ")")
        }
        
        for data in instructs {
            let temp = data as! InstructionItem
            print("(", temp.id!, ", ", temp.name!, ", ", temp.read!, ")")
        }
        
        for data in keys {
            let temp = data as! Keyword
            print("(", temp.keywordId!, ", ", temp.keyword!, ", ", temp.rank!, ", ", temp.description!, ", ", temp.createTime!, ", ", temp.lastUpdateTime!, ")")
        }
        
        for data in mappings {
            let temp = data as! MappingKeyword
            print("(", temp.unitId!, ", ", temp.keyword!, ")")
        }
        
        for data in mobiles {
            let temp = data as! MobileApps
            print("(", temp.appId, ", ", temp.appName!, ", ", temp.appIOSUrl!, ", ", temp.appImage!, ", ", temp.lastUpdateTime, ")")

        }
    }
    
    
    
    // MARK: - DataSyncer
    func syncAllTables() {
        /* dataSyncer */
        let dataSyncer = DataSyncer.createInstance("project_1450347754")
        dataSyncer?.dataSyncListener = self;
        dataSyncer?.startSync()
        dataSyncer?.getData(DBCol.TABLE_ADMINISTRATIVE_UNIT, time:Int(self.databaseHelper.getLastUpdateTime(tableName: DBCol.TABLE_ADMINISTRATIVE_UNIT)))
        dataSyncer?.getData(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY, time: Int(self.databaseHelper.getLastUpdateTime(tableName: DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)))
        dataSyncer?.getData(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY, time: Int(self.databaseHelper.getLastUpdateTime(tableName: DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)))
        dataSyncer?.getData(DBCol.TABLE_KEYWORD, time: Int(self.databaseHelper.getLastUpdateTime(tableName: DBCol.TABLE_KEYWORD)))
        dataSyncer?.getData(DBCol.TABLE_IN_KEYWORD, time: Int(self.databaseHelper.getLastUpdateTime(tableName: DBCol.TABLE_IN_KEYWORD)))
        dataSyncer?.getData(DBCol.TABLE_EDM, time: Int(self.databaseHelper.getLastUpdateTime(tableName: DBCol.TABLE_EDM)))
        dataSyncer?.getData(DBCol.TABLE_MOBILEAPP, time: Int(self.databaseHelper.getLastUpdateTime(tableName: DBCol.TABLE_MOBILEAPP)))
    }
    
    
    
    // MARK: - DataSyncerListener protocol methods
    // DataSyncerListener protocol method
    func onGetData(_ pTableName: String!, data: Any!) {
        // test part:
        /*
         do {
         //                let convertedData = data as! NSDictionary
         //                let obj = try JSONSerialization.jsonObject(with: convertedData, options: JSONSerialization.ReadingOptions.mutableContainers)
         //                self.databaseHelper.syncKeywordTable(jsonObj: obj as! JSON)
         } catch _ {
         print("administrative unit data receive error.")
         }
         */
        
        if (pTableName == DBCol.TABLE_ADMINISTRATIVE_UNIT) {
            // NSDictionary
//            self.databaseHelper.syncAdministrativeUnitTable(jsonObj: data as! NSDictionary)
            
            // Swifty.JSON
            let obj = JSON(data)
            self.databaseHelper.syncAdministrativeUnitTable(jsonObj: obj)
        } else if (pTableName == DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) {
            let obj = JSON(data)
            self.databaseHelper.syncAdministrativeUnitCategory(jsonObj: obj)
        } else if (pTableName == DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY) {
            let obj = JSON(data)
            self.databaseHelper.syncAdministrativeUnitInCategory(jsonObj: obj)
        } else if (pTableName == DBCol.TABLE_KEYWORD) {
            let obj = JSON(data)
            self.databaseHelper.syncKeywordTable(jsonObj: obj)
        } else if (pTableName == DBCol.TABLE_IN_KEYWORD) {
            let obj = JSON(data)
            self.databaseHelper.syncInKeyword(jsonObj: obj)
        } else if (pTableName == DBCol.TABLE_EDM) {
            let obj = JSON(data)
            self.databaseHelper.syncEdmTable(jsonObj: obj)
        } else if (pTableName == DBCol.TABLE_MOBILEAPP) {
            let obj = JSON(data)
            self.databaseHelper.syncMobileApp(jsonObj: obj)
        }
    }
    
    // protocol method
    func onSyncerStatus(_ status: SyncStatus) {
        if (status == SYNC_START) {
            print("start syncing data...")
        } else if (status == SYNC_DONE || status == SYNC_SERVER_FAIL) {
            self.isSyncComplete = true
            print("done syncing.")
            // remove syncing view
            self.syncingView.removeFromSuperview()
            
            
        } else if (status == SYNC_INTERNET_FAIL) {
            print("suncing, internet fail.")
            let actionSheetController: UIAlertController = UIAlertController(title: "警告", message: "網路連線錯誤！", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "確認", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - test query
    func testQuery() {
        let administrativeUnitArray = self.databaseHelper.queryAdministrativeUnitTable()
        let administrativeUnitCategoryArray = self.databaseHelper.queryAdministrativeUnitCategoryTable()
        let adminstrativeUnitInArray = self.databaseHelper.queryAdministrativeUnitInCategoryTable()
        let inKeywordArray = self.databaseHelper.queryInKeywordTable()
        let keywordArray = self.databaseHelper.queryKeywordTable()
        let edmArray = self.databaseHelper.queryEdmTable()
        let mobileappsArray = self.databaseHelper.queryMobileAppTable()
        
        // print out all table data
        for data in administrativeUnitArray {
            let temp = data as! AdministrativeUnit
            print("administrative unit -> x: ", temp.x!, ", y: ", temp.y!, ", fieldId: ", temp.fieldId!, ", unitId: ", temp.unitId!, ", parentUnitId: ", temp.parentUnitId!, ", name: ", temp.name!, ", tel: ", temp.tel!, ", fax: ", temp.fax!, ", email: ", temp.email!, ", website: ", temp.website!, ", description: ", temp.description!, ", iconName: ", temp.iconName!, ", createTime: ", temp.createTime!, ", lastUpdateTime: ", temp.lastUpdateTime!, ", nearByPathId: ", temp.nearByPathId!, ", keyword: ", temp.keyword!)
        }
        
        for data in administrativeUnitCategoryArray {
            let temp = data as! AdministrativeUnitCategory
            print("administrative unit category -> categoryId: ", temp.categoryId!, ", name: ", temp.name!, ", description: ", temp.description!, ", iconName: ", temp.iconName!, ", createTime: ", temp.createTime, ", lastUpdateTime: ", temp.lastUpdateTime, ", keyword: ", temp.keyword!)
        }
        
        for data in adminstrativeUnitInArray {
            let temp = data as! AdministrativeUnitInCategory
            print("administrative unit in category -> unitId: ", temp.unitId!, ", categoryId: ", temp.categoryId!, ", lastUpdateTime: ", temp.lastUpdateTime!)
        }
        
        for data in edmArray {
            let temp = data as! Edm
            print("edm -> edmId: ", temp.edmId!, ", edmName: ", temp.edmName!, ", edmURL: ", temp.edmURL!, ", edmImage: ", temp.edmImage!, ", edmEndDay: ", temp.edmEndDay!, ", lastUpdateTime: ", temp.lastUpdateTime!)
        }
        
        for data in inKeywordArray {
            let temp = data as! InKeywords
            print("(inKeyword -> id: ", temp.stringId!, ", keywordId: ", temp.keywordId!, ", lastUpdateTime: ", temp.lastUpdateTime!, ")")
        }
        
        for data in keywordArray {
            let temp = data as! Keyword
            print("(keyword -> keywordId: ", temp.keywordId!, ", keyword: ", temp.keyword!, ", rank: ", temp.rank!, ", description: ", temp.description!, ", createTime: ", temp.createTime!, ", lastUpdateTime: ", temp.lastUpdateTime!, ")")
        }
        
        for data in mobileappsArray {
            let temp = data as! MobileApps
            print("(mobileapp -> appId: ", temp.appId!, ", appName: ", temp.appName!, ", appIOSUrl: ", temp.appIOSUrl!, ", appImage: ", temp.appImage!, ", lastUpdateTime: ", temp.lastUpdateTime!, ")")
        }

    }
    
}

