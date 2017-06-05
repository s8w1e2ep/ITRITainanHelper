//
//  NavigationDetailViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 6/5/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class NavigationDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var detailTableView: UITableView!
    var categoryId = String()
    var databaseHelper = DatabaseHelper.init(name: "test_1.sqlite")
    var dataArray = NSMutableArray()
    var selectedRow = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.dataArray = self.databaseHelper.queryAdministrativeUnitByCategoryId(categoryId: self.categoryId)
        self.detailTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    
    func goLocation(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "navigationMapVC") as! NavigationMapViewController
        controller.currentAdminUnit = self.dataArray.object(at: self.selectedRow) as! AdministrativeUnit
        controller.isNavigation = false
        self.present(controller, animated: true, completion: nil)
        print("go location")
    }
    
    func goNavigation(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "navigationMapVC") as! NavigationMapViewController
        controller.currentAdminUnit = self.dataArray.object(at: self.selectedRow) as! AdministrativeUnit
        controller.isNavigation = true
        self.present(controller, animated: true, completion: nil)
        print("go navigation")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
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
