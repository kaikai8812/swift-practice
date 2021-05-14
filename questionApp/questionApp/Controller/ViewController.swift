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
    
    
    var correctCount = 0  //正答数
    var wrongCount = 0   //誤答数
    var maxScore = 0    //最高得点
    var questionNumber = 0 //問題番号
    
    
    //よういした画像データ等を、変数に代入
    let imagelist = ImagesList()
    
    //回答を入れておく変数
    var pickedAnswer = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //画面表示の際に、毎回読み込まセル記述
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        correctCount = 0
        wrongCount = 0
        questionNumber = 0
        
        imageView.image = UIImage(named: imagelist.list[0].imageText)
        
    }

    //senderは、押されたボタンそのもの(UIButton)とみなされる。
    @IBAction func answer(_ sender: Any) {
        //丸ボタンが押された時
        if (sender as AnyObject).tag == 1{  //丸ボタンが押された時

            //丸ボタンが押されたということ
            pickedAnswer = true

            //丸ボタンの音声

        } else if (sender as AnyObject).tag == 2{ //×ボタンが押された時

            //×ボタンが押されたということ
            pickedAnswer = false

            //×ボタンの音声
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

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }
    

    
}

