//
//  NavigationDetailTableViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class NavigationDetailTableViewController: UITableViewController {

    // every cell: 左邊 imageView, 中間上面: 局處名稱, 中間下面(小字): 電話號碼, 右邊上面: 位置 按鈕, 右邊下面: 導航 按鈕
    var categoryId = String()
    var databaseHelper = DatabaseHelper.init(name: "test_1.sqlite")
    var dataArray = NSMutableArray()
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // use categoryId to query data and display
        self.dataArray = self.databaseHelper.queryAdministrativeUnitByCategoryId(categoryId: self.categoryId)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let currentItem = self.dataArray.object(at: indexPath.row) as! AdministrativeUnit
        // leftmost image
        let leftImage = UIImageView()
        if (indexPath.row % 2 == 0) {
            leftImage.image = UIImage(named: "index_logo1.png")
        } else {
            leftImage.image = UIImage(named: "govenment_128.png")
        }
        leftImage.frame = CGRect(x: cell.contentView.bounds.origin.x, y: cell.contentView.bounds.origin.y, width: cell.contentView.bounds.size.width/4, height: cell.contentView.bounds.size.height)
        cell.contentView.addSubview(leftImage)
        
        // title 
        let title = UILabel(frame: CGRect(x: cell.contentView.bounds.origin.x + cell.contentView.bounds.size.width/4, y: cell.contentView.bounds.origin.y, width: cell.contentView.bounds.size.width/2, height: cell.contentView.bounds.size.height * 3/5))
        title.text = currentItem.name
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        // detail
        let detail = UILabel(frame: CGRect(x: cell.contentView.bounds.origin.x + cell.contentView.bounds.size.width/4, y: cell.contentView.bounds.origin.y + cell.contentView.bounds.size.height*3/5, width: cell.contentView.bounds.size.width/2, height: cell.contentView.bounds.size.height * 3/5))
        detail.text = currentItem.tel
        detail.font = UIFont.systemFont(ofSize: 11)
        detail.numberOfLines = 0
        detail.lineBreakMode = .byWordWrapping
        
        let locationButton = UIButton(frame: CGRect(x: cell.contentView.bounds.origin.x + cell.contentView.bounds.size.width*3/4, y: cell.contentView.bounds.origin.y, width: cell.contentView.bounds.size.width/4, height: cell.contentView.bounds.size.height/2))
        locationButton.setTitle("位置", for: .normal)
        locationButton.setTitleColor(UIColor.white, for: .normal)
        locationButton.setBackgroundImage(UIImage(named: "button.png"), for: .normal)
        locationButton.addTarget(self, action: #selector(self.goLocation(sender:)), for: .touchUpInside)
        
        let navigationButton = UIButton(frame: CGRect(x: cell.contentView.bounds.origin.x + cell.contentView.bounds.size.width*3/4, y: cell.contentView.bounds.origin.y + cell.contentView.bounds.size.height/2, width: cell.contentView.bounds.size.width/4, height: cell.contentView.bounds.size.height/2))
        navigationButton.setTitle("導航", for: .normal)
        navigationButton.setTitleColor(UIColor.white, for: .normal)
        navigationButton.setBackgroundImage(UIImage(named: "button.png"), for: .normal)
        navigationButton.addTarget(self, action: #selector(self.goNavigation(sender:)), for: .touchUpInside)
        
        cell.contentView.addSubview(leftImage)
        cell.contentView.addSubview(title)
        cell.contentView.addSubview(detail)
        cell.contentView.addSubview(locationButton)
        cell.contentView.addSubview(navigationButton)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // update counter
        self.selectedRow = indexPath.row
    }
    
    func goLocation(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "navigationMapVC") as! NavigationMapViewController
        controller.adminUnit = self.dataArray.object(at: self.selectedRow) as! AdministrativeUnit
        controller.isNavigation = false
        self.present(controller, animated: true, completion: nil)
        print("go location")
    }
    
    func goNavigation(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "navigationMapVC") as! NavigationMapViewController
        controller.adminUnit = self.dataArray.object(at: self.selectedRow) as! AdministrativeUnit
        controller.isNavigation = true
        self.present(controller, animated: true, completion: nil)
        print("go navigation")
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
