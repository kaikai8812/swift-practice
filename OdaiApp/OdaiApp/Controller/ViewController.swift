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

class ViewController: UIViewController,UITextViewDelegate {
    
    //お題データを受信するデータベースの場所を設定
    let db1 = Firestore.firestore().collection("Odai").document("6fqTXCag3aCbkQM1RwIZ")
    
    //回答データを送信するデータベースの場所を設定するための変数
    let db2 = Firestore.firestore()
    
    var userName = String()
    
    var idString = String()  //いいね機能の際に追加
    
    
    @IBOutlet weak var textview: UITextView!
    
    
    @IBOutlet weak var odaiLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UserDefaults.standard.object(forKey: "userName") != nil{
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        
        textview.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        loadQuestiondata()
        
        if UserDefaults.standard.object(forKey: "documentID") != nil {
            idString = UserDefaults.standard.object(forKey: "documentID") as! String
            print(idString)
            print("aoyama")
        }else{
            //setDataを使わなければ、データがfireStoreに保存されないが、パスを持ってくることはできる
            idString = Firestore.firestore().collection("Answers").document().path
            print(idString)
            idString = String(idString.dropFirst(8))
            UserDefaults.standard.setValue(idString, forKey: "documentID")
        }
        print(idString)
        print("aoyama")
        
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
        
        
        //いいねを含めた際での処理
        db2.collection("Answers").document(idString).setData(["answer" : textview.text as Any, "userName": userName as Any, "postDate":Date().timeIntervalSince1970, "like":0, "likeFlagDic":[idString:false]])
        
        
        //setDataの方は、コメントアウトしています。
//        db2.collection("Answers").document().setData(["answer" : textview.text as Any, "userName": userName as Any, "postDate":Date().timeIntervalSince1970 ])
        
//        db2.collection("Answers").addDocument(data: ["answer" : textview.text as Any, "userName": userName as Any, "postDate":Date().timeIntervalSince1970 ]) { error in
//
//            if error != nil{
//                print(error.debugDescription)
//                return
//            }
//
//        }
//
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
    
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            
            UserDefaults.standard.removeObject(forKey: "userName")
            UserDefaults.standard.removeObject(forKey: "documentID")
            
        } catch let error as NSError {
            print("error",error)
        }
        
        //前画面に戻る処理
        navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textview.resignFirstResponder()
    }


}

