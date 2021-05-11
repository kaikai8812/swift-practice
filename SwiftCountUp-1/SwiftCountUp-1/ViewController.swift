//
//  ViewController.swift
//  SwiftCountUp-1
//
//  Created by ヘパリン類似物質 on 2021/05/11.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    
    
    @IBOutlet weak var countUpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countUpLabel.text = "0"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func plus(_ sender: Any) {
        //カウントアップする
        count = count + 1
        //ラベルに数字を表示する
        countUpLabel.text = String(count)
        //10以上になったら、数字を黄色にする
        if (count >= 10) {
            changeTextColor()
        }
    }
    
    
    @IBAction func minus(_ sender: Any) {
        //カウントダウンする
        count = count - 1
        //ラベルに数字を表示する
        countUpLabel.text = String(count)
        //0以下になったら、数字を白にする
        if (count <= 0) {
            resetColor()
        }
    }
    
    
    func changeTextColor(){
        countUpLabel.textColor = .yellow
    }
    
    func resetColor(){
        countUpLabel.textColor = .white
    }
    

}

