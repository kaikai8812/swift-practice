//
//  SendToDB.swift
//  ChatApp
//
//  Created by ヘパリン類似物質 on 2021/05/18.
//

import Foundation
import FirebaseStorage

//新規登録後、画面遷移を行うかどうかの判断をするデリゲートメソッドを委任するためのプロトコル
protocol SendProfileOKDelegete {
    func sendProfileOKDelegete(url: String)
}




//プロフィールイメージデータを、storageに保存する

class SendToDBModel {
    
    var sendProfileOKDelegete:SendProfileOKDelegete?
    
    init() {
    }
    
    func sendProfileImageData(data:Data){
        //Data型で、引数を受け取り、それをUIImage型に変換
        let image = UIImage(data: data)
        //データを圧縮
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        //ここで、firestorage側にどう保存するかの設定を行なっている？、パスを設定している。
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        //ここで、FireStorageにデータを送信
        imageRef.putData(profileImageData!, metadata: nil) { metadata, error in
            
            if error != nil{
                print(error.debugDescription)
                return
            }
            //上で送った画像データのありかを示す画像URLをダウンロード。それが、url変数に代入される。
            imageRef.downloadURL { url, error in
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                
                //ダウンロードした画像URLを、文字列にしてアプリ内に保存（チャット送信時に、画像データも使用するため。）
                UserDefaults.standard.set(url?.absoluteString, forKey: "userImage")
                //このタイミングでデリゲードメソッドをRegisterControllerで発動させ、画像がしっかりと保存されているかをかくにんする。
                self.sendProfileOKDelegete?.sendProfileOKDelegete(url: url!.absoluteString )
                
            }
        }
    }
}
