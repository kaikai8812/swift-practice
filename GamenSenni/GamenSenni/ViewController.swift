//
//  ViewController.swift
//  GamenSenni
//
//  Created by ヘパリン類似物質 on 2021/05/12.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func plus(_ sender: Any) {
        
        count = count + 1
        label.text = String(count) //キャスト
        
        if count == 10{
            count = 5
            //画面遷移をする。
            //Modallyを使用した場合の、遷移方法
//            performSegue(withIdentifier: "next", sender: nil)
//            let nextVC = segue.destination as! NextViewController
            
            //NavigationControllerを使用した場合の、遷移方法
            
            let nextVC = storyboard?.instantiateViewController(identifier: "next") as! NextViewController
            
            nextVC.count2 = count
            navigationController?.pushViewController(nextVC, animated: true)
            
            
        }
    }
    
    
    @IBAction func button(_ sender: Any) {
        
        let thirdVC = storyboard?.instantiateViewController(identifier: "third") as! ThirdViewController
        
        thirdVC.count3 = count
        
        navigationController?.pushViewController(thirdVC, animated: true)
        
    }
    
    
    //Modallyを使用して遷移した場合に呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //nextVCという変数に、NextViewControllerを代入する
        let nextVC:NextViewController = segue.destination as! NextViewController
        
        //nextVCの、count2という変数に、countを代入する。
        nextVC.count2 = count
    }
    


}

