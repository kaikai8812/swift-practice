//
//  ViewController.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import UIKit

class ViewController: UIViewController, NowScoreDelegate {

    

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    
    var correctCount = 0  //正答数
    var wrongCount = 0   //誤答数
    var maxScore = 0    //最高得点
    var questionNumber = 0 //問題番号
    
    var soundFile = SoundFile()
    
    
    //よういした画像データ等を、変数に代入
    let imagelist = ImagesList()
    
    //回答を入れておく変数
    var pickedAnswer = Bool()
    
    //モデルの実体化
    var changeColor = ChangeColor()
    
    //CAGradientLayer型は、色のグラデーションが格納されているデータ型
    var gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientLayer = changeColor.changeColor(topR: 0.07, topG: 0.13, topB: 0.26, topAlpha: 1.0, bottomR: 0.54, bottomG: 0.74, bottomB: 0.74, bottomAlpha: 1.0)
        
        //グラディえーションの大きさを決める。view.boundsで、view全体を表す。
        gradientLayer.frame = view.bounds
        
        //viewのlayerに、作成したグラディエーションを差し込む
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        imageView.layer.cornerRadius = 20.0
        
    }
    
    //画面表示の際に、毎回読み込まセル記述
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        correctCount = 0
        wrongCount = 0
        questionNumber = 0
        
        //最初の問題画像を表示
        imageView.image = UIImage(named: imagelist.list[0].imageText)
        
        //maxScoreに、保存されている現在の最高得点を代入
        if UserDefaults.standard.object(forKey: "beforeCount") != nil {
            maxScore = UserDefaults.standard.object(forKey: "beforeCount") as! Int
        }
        //現在の最高得点をviewに表示させる記述
        maxScoreLabel.text = String(maxScore)
    }

    //senderは、押されたボタンそのもの(UIButton)とみなされる。
    @IBAction func answer(_ sender: Any) {
        //丸ボタンが押された時
        if (sender as AnyObject).tag == 1{  //丸ボタンが押された時

            //丸ボタンが押されたということ
            pickedAnswer = true

            //丸ボタンの音声
            soundFile.playsound(filename: "maruSound", extensionName: "mp3")

        } else if (sender as AnyObject).tag == 2{ //×ボタンが押された時

            //×ボタンが押されたということ
            pickedAnswer = false

            //×ボタンの音声
            soundFile.playsound(filename: "batsuSound", extensionName: "mp3")
        }
        
        //pickedAnswerと、画像データのcorrect~~があっているかを確認
        
        check()
        nextQuestions()
    }
    
    
    //回答があっているかを確認
    func check() {
        
        //この問題の、答えを取得
        let correctAnswer = imagelist.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            correctCount = correctCount + 1
            print("正解")
        } else {
            wrongCount = wrongCount + 1
            print("不正解")
        }
        
    }
    
    //次の問題を表示する
    
    func nextQuestions() {
        
        if questionNumber <= 7 {
    
            questionNumber = questionNumber + 1
            imageView.image = UIImage(named: imagelist.list[questionNumber].imageText)
            
        } else {
            print("問題終了")
            
            performSegue(withIdentifier: "next", sender: nil)
        }
    }
    
    
    func nowScore(score: Int) {
        //最高得点を、ラベルに反映させる
        maxScoreLabel.text = String(score)
        
        soundFile.playsound(filename: "sound", extensionName: "mp3")
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next" {
            
            let nextVC = segue.destination as! NextViewController
            nextVC.correctedCount = correctCount
            nextVC.wrongCount = wrongCount
            
            nextVC.delegate = self
            
        }
        
    }
    

    
}

