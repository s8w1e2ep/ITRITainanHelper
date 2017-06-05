//
//  AppsViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/26/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var count = 0
    var apps = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dbHelper = DatabaseHelper.init(name: "test_1.sqlite")
        self.apps = dbHelper.queryMobileAppTable()
        for data in self.apps {
            count += 1
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let dbHelper = DatabaseHelper.init()
        let apps = dbHelper.queryMobileAppTable()
        for app in apps {
            print((app as! MobileApps).appId)
        }
    }
    
    @IBAction func backHomeAlone(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(controller, animated: true, completion: nil)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return count
    }
    // 必須實作的方法：每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            // 依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "AppCell", for: indexPath as IndexPath) as! AppCell
            
            cell.imgApp.image = UIImage(named: "\(indexPath.row+1).png")
            //cell.imgApp.image = UIImage(named: "app_area.jpg")
//            cell.lbTitle.text = "\(indexPath.row+1)"
            let appItem = self.apps.object(at: indexPath.row) as! MobileApps
            cell.lbTitle.text = appItem.appName
            return cell
    }

}
