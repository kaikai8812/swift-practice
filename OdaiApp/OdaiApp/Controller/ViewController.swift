//
//  ViewController.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/19.
//

import UIKit
import Firebase
import FirebaseFirestore
import EMAlertController

class ViewController: UIViewController {
    
    //お題データを受信するデータベースの場所を設定
    let db1 = Firestore.firestore().collection("Odai").document("6fqTXCag3aCbkQM1RwIZ")
    
    //回答データを送信するデータベースの場所を設定するための変数
    let db2 = Firestore.firestore()
    
    var userName = String()
    
    
    @IBOutlet weak var textview: UITextView!
    
    
    @IBOutlet weak var odaiLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.object(forKey: "userName") != nil{
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        loadQuestiondata()
        
    }
    
    func loadQuestiondata(){
        
        //指定したドキュメントから、実際にデータを引っ張ってくる処理
        
        db1.getDocument { snapShot, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
           let data = snapShot?.data()
            
            self.odaiLabel.text = data!["odaiText"] as! String
        }
    }
    
    
    //FireStoreに、回答のデータを送信する
    @IBAction func send(_ sender: Any) {
        
        //setDataの方は、コメントアウトしています。
//        db2.collection("Answers").document().setData(["answer" : textview.text as Any, "userName": userName as Any, "postDate":Date().timeIntervalSince1970 ])
        
        db2.collection("Answers").addDocument(data: ["answer" : textview.text as Any, "userName": userName as Any, "postDate":Date().timeIntervalSince1970 ]) { error in

            if error != nil{
                print(error.debugDescription)
                return
            }

        }
        
        //アラートを表示させる
        alert()

        
    }
    
    //アラート作成
    func alert() {
        let alert = EMAlertController(icon: UIImage(named: "check"), title: "投稿完了", message: "みんなの回答を見てみよう！")
        let doneAction = EMAlertAction(title: "OK", style: .normal)
        alert.addAction(doneAction)
        present(alert, animated: true, completion: nil)
        textview.text = ""
    }
    
    
  
    @IBAction func checkAnswer(_ sender: Any) {
        
        let checkVC = storyboard?.instantiateViewController(identifier: "checkVC") as! CheckViewController
        
        checkVC.odaiString = odaiLabel.text!
        
        navigationController?.pushViewController(checkVC, animated: true)
        
    }
    
    
    
    


}

