//
//  ViewController.swift
//  testyu
//
//  Created by uscc on 2017/3/29.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class FacilityViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    

    
    
    @IBOutlet weak var collect1: UICollectionView!
    let fullScreenSize = UIScreen.main.bounds.size
    
    var guideOverlay = UIView() // black frame
    var isFirst = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*let defaults = UserDefaults.standard
        let checkFirstLaunch = defaults.bool(forKey: "isAppFirstLaunch")
        if (checkFirstLaunch == true) {
            // is first launch
            isFirst = true
            setGuideLayout()
        }*/
    }
        
    
    @IBAction func goBackMain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(controller, animated: true, completion: nil)

    }
    
        
    func checkClick() {
        self.guideOverlay.removeFromSuperview()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 必須實作的方法：每一組有幾個 cell
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var info = ["1樓東側廁所","1樓西側廁所","2樓東側廁所","2樓西側廁所","3樓東側廁所","3樓西側廁所","4樓東側廁所","4樓西側廁所","5樓東側廁所","5樓西側廁所","6樓東側廁所","6樓西側廁所","7樓東側廁所","7樓西側廁所","8樓東側廁所","8樓西側廁所","9樓東側廁所","9樓西側廁所","10樓東側廁所","10樓西側廁所","11樓東側廁所","11樓西側廁所","12樓東側廁所","12樓西側廁所","13樓廁所","14樓廁所","15樓廁所","16樓廁所"]
        let dbHelper = DatabaseHelper.init(name: "test_1.sqlite")
        //var info = dbHelper.getF
        if segue.identifier == "bathroomSegue"{
            var vc = segue.destination as! BathroomViewViewController
            
            vc.info = info
        }
    }
    
 
    // 必須實作的方法：每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            // 依據前面註冊設置的識別名稱 "Cell" 取得目前使用的 cell
            
            if (indexPath.row == 0) {
            let cell =
                collectionView.dequeueReusableCell(
                    withReuseIdentifier: "Cell", for: indexPath as IndexPath)
                
                return cell
            }
            else if(indexPath.row == 1) {
                let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier: "drink", for: indexPath as IndexPath)
                
                return cell
            }
            else if(indexPath.row == 2) {
                let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier: "elevator", for: indexPath as IndexPath)
                
                return cell
            }
            else if(indexPath.row == 3) {
                let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier: "nurse", for: indexPath as IndexPath)
                
                return cell
            }
            else if(indexPath.row == 4) {
                let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier: "shop", for: indexPath as IndexPath)
                
                return cell
                
            }
            else if(indexPath.row == 5) {
                let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier: "hair", for: indexPath as IndexPath)
                
                return cell
            }
                
            else{
                let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier: "Cell", for: indexPath as IndexPath)
                
                return cell
            }
    }
    
    
    //func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       // if indexPath.row == 0 {
       //     self .present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
      //  }
        
    //}
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bathroomSegue" {
            let yude: BathroomViewViewController!
            yude.array = self.array
        }
    }*/
    
    }
