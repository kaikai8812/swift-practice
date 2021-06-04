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
        Firestore.firestore().collection("collection").document().setData(["text" : textField.text!])
        
        //追加部分 ==================================================================
        let hashTagText = textField.text as NSString?
        
        do{
            let regex = try NSRegularExpression(pattern: "#\\S+", options: [])
            //見つけたハッシュタグを、for文で回す。
            for match in regex.matches(in: hashTagText! as String, options: [], range: NSRange(location: 0, length: hashTagText!.length)) {
                
                //見つかったハッシュタグを引数に入れデータベースに保存
                Firestore.firestore().collection(hashTagText!.substring(with: match.range)).document().setData(["text" : self.textField.text!])
            }
        }catch{
        }
        //追加部分 ==================================================================
        
        //データを保存したら、画面遷移を行います。
        let tableVC = storyboard?.instantiateViewController(identifier: "tableVC") as! TableViewController
        navigationController?.pushViewController(tableVC, animated: true)
    }
}
