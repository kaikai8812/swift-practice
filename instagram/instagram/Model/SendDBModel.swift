
//プロフィールイメージをFireStorageへ保存、および受信するためのメソッド

import Foundation
import FirebaseStorage

class SendDBModel {
    
    init(){
        
    }
    
    func sendProfileImageData(data:Data) {
        
        //関数の引数で受け取ったデータを、UIImage型で、imageに格納
        let image = UIImage(data: data)
        
        //imageを、Data型に変更しつつ、容量を圧縮
        let profileImage = image?.jpegData(compressionQuality: 0.1)
        
        //FireStorageの、profileImageフォルダの中に、一意の文字列+その時の日付+jpgというデータの保存先を変数に入れたイメージ
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        //imageRefという保存先に、profileImageというデータをまずは保存する。
        imageRef.putData(Data(profileImage!), metadata: nil) { metadata, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            //ここで、帰ってきた画像URLを、アプリ内に保存する
            imageRef.downloadURL { url, error in
                
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                //受け取ったURLを、String型に変換して、アプリ内に保存
                UserDefaults.standard.set(url?.absoluteString, forKey: "userImage")
                
            }
        }
    }
}
