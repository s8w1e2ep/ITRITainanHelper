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
    var defaultiOSUrl = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let dbHelper = DatabaseHelper.init(name: "test_1.sqlite")
        self.apps = dbHelper.queryMobileAppTable()
        for _ in self.apps {
            count += 1
            
        }
        defaultiOSUrl = ["itms://itunes.apple.com/tw/app/open台南1999/id1053874613?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/大台南公車/id492634854?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/t-bike臺南市公共自行車/id1135691792?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/fu-cheng-jing-zheng-xiao-bang/id858971002?mt=8",
                        "itms://itunes.apple.com/tw/app/tai-nan-hao-ting/id1073940510?mt=8",
                        "itms://itunes.apple.com/tw/app/tai-nan-gu-ji-dao-lan/id985183749?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/nan-ying-tian-wen-guan/id917590342?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/lu-xing-tai-nan-lite/id1103151928?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/tai-nan-shui-qing-ji-shi-tong/id590994074?mt=8",
                        "itms://itunes.apple.com/tw/app/nan-shi-de-zhenge-wang-tong/id1102397319?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/an-pinggo-hao-xing/id945547333?mt=8",
                        "itms://itunes.apple.com/tw/app/巷弄x臺南/id1067765395?l=zh&mt=8",
                        "itms://itunes.apple.com/tw/app/yun-you-xue/id987365795?mt=8",
                        "itms://itunes.apple.com/tw/app/smart健康/id1119052913?l=zh&mt=8",
                        "itms://itunes.apple.com/qa/app/oh!-tai-nan/id954729774?mt=8",
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
            
            let appItem = self.apps.object(at: indexPath.row) as! MobileApps
            
            //cell.imgApp.image = UIImage(named: appItem.appImage!)
            cell.imgApp.image = UIImage(named: "\(indexPath.row+1).png")
            
            cell.lbTitle.text = appItem.appName
            
            return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        //let appItem = self.apps.object(at: indexPath.row) as! MobileApps
        //UIApplication.shared.open(URL(string: ("itms://"+appItem.appIOSUrl).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!, options: [:], completionHandler: nil)
        if defaultiOSUrl[indexPath.row] as! String != "NULL" {
            UIApplication.shared.open(URL(string: (defaultiOSUrl[indexPath.row] as! String).addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!, options: [:], completionHandler: nil)
            print(defaultiOSUrl[indexPath.row] as! String)
        }
        
    }

}
