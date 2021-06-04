//
//  ViewController.swift
//  Qiita-HashTag
//
//  Created by ヘパリン類似物質 on 2021/06/04.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {
    
    //文字列を入力するtextFieldに紐づいています。
    @IBOutlet weak var textField: UITextField!
    
    //投稿するボタンに紐づいています。
    @IBAction func send(_ sender: Any) {
        //入力された文字列を引数に、下記に記述したメソッドを呼んでいます。
        sendDB(text: textField.text!)
    }
    
    //入力されたデータを、fireStoreに保存するための記述です。
    func sendDB(text:String) {
        //fireStoreに保存する処理
        Firestore.firestore().collection("collection").document().setData(["text" : text])
        //データを保存したら、画面遷移を行います。
        let tableVC = storyboard?.instantiateViewController(identifier: "tableVC") as! TableViewController
        navigationController?.pushViewController(tableVC, animated: true)
    }
}

