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
