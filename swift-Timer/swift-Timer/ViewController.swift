//
//  ViewController.swift
//  swift-Timer
//
//  Created by ヘパリン類似物質 on 2021/05/11.
//

import UIKit  //ツールを使用できるようにしている。

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var timer = Timer() //Timerクラスという設計図から、timerを生成
    
    var count = Int()  //Int型の変数を指定
    
    var imageArray = [UIImage]() //UIImage型の配列を指定。
    //swiftは、配列を作る際なども、クラスを指定しておく必要がある。
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //stopボタンを押せなくする。
        stopButton.isEnabled = false
        //プロパティ-・・・クラスが持っている使用できるメソッド的なもの
        
        count = 0
        
        //for文を用いて、logを表示させる。
        for i in 0..<5{
            print(i)
            let image = UIImage(named: "\(i)") //UIImageは、assetsに入れたデータに対応したクラス？
            imageArray.append(image!)
        }
        
        //初期画像を表示
        imageView.image = UIImage(named: "0" )
        
        
    }
    
    func startTimer() {
        
        //0.2秒ごとに、timerUpdateという関数を呼ぶ処理
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timerUpdate(){
        count = count + 1
        
        if count > 4 {
            count = 0
        }
        
        imageView.image = imageArray[count]
    }
    
    @IBAction func start(_ sender: Any) {
        
        //imageViewのimageに、画像を反映させていく。
        
        //startボタンを押せなくする。
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        startTimer()
    }
    

    @IBAction func stop(_ sender: Any) {
        
        //imageViewに表示されている画像の流れをストップする。
        
        //startButtonを押せるようにする。
        startButton.isEnabled = true
        stopButton.isEnabled = false
        timer.invalidate() //timerを終了させる。
        
        
    }
    
}
