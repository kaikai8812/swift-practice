//
//  LoadDBModel.swift
//  instagram
//
//  Created by ヘパリン類似物質 on 2021/05/23.
//

import Foundation
import Firebase

protocol LoadOKDelegate {
    func loadOK(check:Int)
}

class LoadDBModel {
    
    var dataSets = [DataSet]()
    let db = Firestore.firestore()
    
    var loadOKDelegate:LoadOKDelegate?
    
    
    //目的 datasetsに、fireStoreからとってきたデータを配列として保存して、tableViewに反映できるようにする。
    func loadContents(roomnumber:String) {
        
        db.collection(roomnumber).order(by: "postDate").addSnapshotListener { snapShot, error in
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if let userID = data["userID"] as? String, let userName = data["userName"] as? String, let profileImage = data["userImage"] as? String,let contentImage = data["contentImage"] as? String, let postDate = data["postDate"] as? Double, let comment = data["comment"] as? String{
                        
                        
                        let newDataSet = DataSet(userID: userID, userName: userName, comment: comment, profileImage: profileImage, postDate: postDate, contentImage: contentImage)
                        
                        self.dataSets.append(newDataSet)
                        self.dataSets.reverse()
                    }
                    
                }
            }
        }
    }
    
    //ハッシュタグ関係のロード
    
    func loadHashTag(hashTag:String){
            //addSnapShotListnerは値が更新される度に自動で呼ばれる
            db.collection("#\(hashTag)").order(by:"postDate").addSnapshotListener { (snapShot, error) in
                
                self.dataSets = []
                
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                if let snapShotDoc = snapShot?.documents{
       
                    for doc in snapShotDoc{
                        let data = doc.data()
                        if let userID = data["userID"] as? String ,let userName = data["userName"] as? String, let comment = data["comment"] as? String,let profileImage = data["userImage"] as? String,let contentImage = data["contentImage"] as? String,let postDate = data["postDate"] as? Double {
                            
                            let newDataSet = DataSet(userID: userID, userName: userName, comment: comment, profileImage: profileImage, postDate: postDate, contentImage: contentImage)

                            self.dataSets.append(newDataSet)
                            self.dataSets.reverse()
                            
                            //完全にデータが入った後に、HashTagViewのデータをリロードする。(正しい値が入っていることを担保している？)
                            self.loadOKDelegate?.loadOK(check: 1)

                        }
                    }
                }
            }
        }

}
