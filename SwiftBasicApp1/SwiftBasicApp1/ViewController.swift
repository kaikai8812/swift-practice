//
//  ViewController.swift
//  SwiftBasicApp1
//
//  Created by ヘパリン類似物質 on 2021/05/11.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var tapLabel: UILabel!
    
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    

    @IBAction func tap(_ sender: Any) {
        count = count + 1
        
        countLabel.text = String(count)
        
        if count % 2 == 0  {
        
            imageView.image = UIImage(named: "back2")
            tapLabel.text = "2で割り切れる数値です。"
            
        } else if count > 5 {
            
            imageView.image = UIImage(named: "back3")
        } else {
            tapLabel.text = "奇数です。"
        }
        
//        switch count {
//        case 5:
//            tapLabel.text = "数値は5です。"
//            break
//        case 7:
//            tapLabel.text = "数値は7です。"
//            break
//        default:
//            tapLabel.text = "何でもない数値です。"
//        }
        
    }

}

