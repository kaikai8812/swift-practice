
//プロフィールイメージをFireStorageへ保存、および受信するためのメソッド

import Foundation
import FirebaseStorage
import FirebaseFirestore

class SendDBModel {
    
    //会員登録の際に使用する初期化設定
    init(){
    }
    
    
    //投稿の際に使用する変数
    var userID = String()
    var userName = String()
    var comment = String()
    var userImageString = String()
    var contentImageData = Data()
    
    var db = Firestore.firestore()
    
    //投稿の際に使用する初期化設定
    init(userID:String, userName:String, comment:String, userImageString:String, contentImageData:Data) {
        self.userID = userID
        self.userName = userName
        self.comment = comment
        self.userImageString = userImageString
        self.contentImageData = contentImageData
    }
    
    //投稿データを、fireStoreに保存する処理を記述
    func sendData(roomNumber:String) {
        
        //FireStorageの、Imagesフォルダの中に、一意の文字列+その時の日付+jpgというデータの保存先を変数に入れたイメージ
        let imageRef = Storage.storage().reference().child("images").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        //imageRefという保存先に、というデータをまずは保存する。
        imageRef.putData(Data(contentImageData), metadata: nil) { metadata, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            //投稿画像URlが変数urlに保存される。
            imageRef.downloadURL { [self] url, error in
                
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                //roomNumberをキーにして、辞書型で以下のデータを保存する。
                self.db.collection(roomNumber).document().setData(["userID" : self.userID as Any, "userName" : self.userName as Any, "comment" : self.comment as Any, "userImage" : self.userImageString, "contentImage" : url?.absoluteString as Any, "postDate" : Date().timeIntervalSince1970 ])
                
            }
        }
    }
            
            
            //プロフィール画像を保存し、館員登録するためのメソッド
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
