//
//  ActivityViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/26/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import FeedKit
import SQLite


class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tvActivity: UITableView!
    @IBOutlet weak var navigationbar: UINavigationBar!
    @IBOutlet weak var mswitch: UISwitch!
    
    let fullScreenSize = UIScreen.main.bounds.size
    let dbHelper = DatabaseHelper.init()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    var items = [ActivityRSSFormat]()
    var hotitems = NSMutableArray()
    var overlay: UIView = UIView()// black frame
    var guideOverlay = UIView() // black frame
    var isFirst = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbHelper.createHotTable()
        
        let defaults = UserDefaults.standard
        let checkFirstLaunch = defaults.bool(forKey: "isAppFirstLaunch")
        if (checkFirstLaunch == true) {
            // is first launc
            isFirst = true
            setGuideLayout()
        } else {
            setGeneralLayout()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // loadActivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadActivity()
    }
    
    func setGuideLayout() {
        // set button
        let btnCheck: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 210, height: 73))
        btnCheck.setTitle("確定", for: .normal)
        btnCheck.setTitleColor(UIColor.white, for: .normal)
        btnCheck.isEnabled = true
        btnCheck.setBackgroundImage(UIImage(named: "instruction_button.png"), for: .normal)
        btnCheck.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.2)
        btnCheck.addTarget(self, action: #selector(self.checkClick), for: .touchUpInside)
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
    
    // set gerneral layout
    func setGeneralLayout() {
        self.tvActivity.layoutMargins = UIEdgeInsets.zero
        // set overlay
        overlay.frame = CGRect(x: 0,y: 0, width: view.frame.size.width * 0.8, height: 90)
        overlay.center = self.view.center
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.5
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        // set loading indicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height:60)
        activityIndicator.center = CGPoint(x: overlay.frame.size.width / 2, y: overlay.frame.size.height / 2);
        activityIndicator.hidesWhenStopped = true
        
        overlay.addSubview(activityIndicator)
        self.view.addSubview(overlay)
        activityIndicator.startAnimating()
    }
    
    func loadAPI(){
        // call API and transfer response to rss format
        let url = URL(string: "http://www.tainan.gov.tw/tainan/rss.asp?nsub=__A4A0")!
        
        DispatchQueue.global(qos: .userInitiated).async {
            FeedParser(URL: url)?.parse({ (result) in
                DispatchQueue.main.async {
                    let list = result.rssFeed?.items!
                    var dataStr :String!
                    var count = Int64(0)
                    for item in list! {
                        dataStr = "\(String(describing: item.pubDate))"
                        if self.dbHelper.insertOrUpdateHotTable(id: count, hotDate: dataStr, hotTitle: item.title!, hotDescription: item.description!, hotLink: item.link!, isDelete: 0) {
                            // do something
                        }
                        count = count + 1
                    }
                }
            })
        }
    }
    
    func loadActivity(){
        loadAPI()
        hotitems = dbHelper.queryHotTable()
        for item in self.hotitems{
            let temp = item as! HotItem
            if(temp.isDelete == 0){
                let st = temp.hotDate!
                var range = st.range(of: "(")
                var date_format = st.substring(from: (range?.upperBound)!)
                range = date_format.range(of: " +")
                date_format = date_format.substring(to: (range?.lowerBound)!)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
                let date = dateFormatter.date(from: date_format)
                self.items.append(ActivityRSSFormat(title: temp.hotTitle, pubDate: date, link: temp.hotLink, description: temp.hotDescription))
            }
        }
        self.tvActivity.reloadData()
        self.activityIndicator.stopAnimating()
        self.overlay.removeFromSuperview()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func btnClick(button:UIButton){
        
        let alertController = UIAlertController(title: "btnclick", message: "\(button.tag)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        let st = "\(String(describing: items[indexPath.row].pubDate))"
        var range = st.range(of: "(")
        var data = st.substring(from: (range?.upperBound)!)
        range = data.range(of: " +")
        data = data.substring(to: (range?.lowerBound)!)
        cell.index.text = "\(indexPath.row)"
        cell.title.text = items[indexPath.row].title
        cell.title.numberOfLines = 0;
        cell.title.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.date.text = "發布日期" + "\(String(describing: data))"
        cell.date.numberOfLines = 0;
        cell.date.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.btn.tag = indexPath.row
        cell.btn.setBackgroundImage(#imageLiteral(resourceName: "recycle_bin"), for: UIControlState())
        cell.btn.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
        vc.title = items[indexPath.row].title
        vc.content = items[indexPath.row].description
        show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage() {
        let alertController = UIAlertController(title: "Loading...", message: "\n\(items.count)\n\n", preferredStyle: .alert)
        
        let loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loading.center = CGPoint(x:30,y:30)
        loading.color = UIColor.black
        loading.startAnimating()
        
        /*let indicatorLength: CGFloat = 30.0   //正方形
         let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
         indicatorView.frame = CGRect(x: (rootRect?.width)!/2-indicatorLength/2, y: (rootRect?.height)!/2-indicatorLength/2, width: indicatorLength, height: indicatorLength)
         */
        alertController.view.addSubview(loading)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backEvent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        self.present(controller, animated: true, completion: nil)
    }
}
