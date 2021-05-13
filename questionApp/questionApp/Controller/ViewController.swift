//
//  ViewController.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //senderは、押されたボタンそのもの(UIButton)とみなされる。
    @IBAction func answer(_ sender: Any) {
        //丸ボタンが押された時
        if (sender as AnyObject).tag == 1{  //丸ボタンが押された時

            //丸ボタンが押されたということ

            //丸ボタンの音声

        } else if (sender as AnyObject).tag == 2{ //×ボタンが押された時

            //×ボタンが押されたということ

            //×ボタンの音声
        }
    }
    

    
}

