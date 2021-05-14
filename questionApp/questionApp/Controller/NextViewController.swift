//
//  NextViewController.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import UIKit

protocol NowScoreDelegate {
    func nowScore(score:Int)
}

class NextViewController: UIViewController {
    
    
    @IBOutlet weak var correctLabel: UILabel!
    
    @IBOutlet weak var wrongLabel: UILabel!
    
    var delegate:NowScoreDelegate?
    
    var correctedCount = Int()
    var wrongCount = Int()
    
    var beforeCount = Int()  //delegateで、beforecountには値を入れる
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctLabel.text = String(correctedCount)
        wrongLabel.text = String(wrongCount)
        
        //保存されている今まででの最高得点を代入
        if UserDefaults.standard.object(forKey: "beforeCount") != nil {
            beforeCount = UserDefaults.standard.object(forKey: "beforeCount") as! Int
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        //もし、最高得点ならば、データを更新
        
        if beforeCount < correctedCount {
            
            //最高得点を、アプリ内データに保存
            UserDefaults.standard.set(correctedCount, forKey: "beforeCount")
            delegate?.nowScore(score: correctedCount)
            
        }else if beforeCount > correctedCount { //ここの条件式の中身、今回のアプリには必要なし！

            UserDefaults.standard.set(beforeCount, forKey: "beforeCount")
            
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    

}
