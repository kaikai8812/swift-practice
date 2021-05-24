//
//  MusicModel.swift
//  tiktok
//
//  Created by ヘパリン類似物質 on 2021/05/24.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol MusicProtocol {
    func catchData(count:Int)
}

class MusicModel {
    var artistNameArray = [String]()
    var trackCensoredNameArray = [String]()
    var preViewURLArray = [String]()
    var artWorkUrl100Array = [String]()
    
    //プロトコルのインスタンス化
    var MusicDelegate:MusicProtocol?
    
    func setData(resultCount:Int, encodeUrlString:String) {
        
        //APIとの通信
        AF.request(encodeUrlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { [self] responce in
            
            self.artistNameArray.removeAll()
            self.trackCensoredNameArray.removeAll()
            self.preViewURLArray.removeAll()
            self.artWorkUrl100Array.removeAll()
            
            //responce.resultにデータ受信に成功したかどうかが返ってくるので、その中身に対してswitch文を使用する。
            switch responce.result{
            case .success:
                
                //do内でエラーが生じた際に、catch文の中身が呼ばれる。
                do {
                    let json:JSON = try JSON(data: responce.data!)
                    //for分を回して、引数で受け取った数分だけのデータを、配列に追加していく。
                    for i in 0...resultCount - 1{
                        
                        if json["results"][i]["artistName"].string == nil {
                            print("ヒットしませんでした！")
                            return
                        }
                        
                        self.artistNameArray.append(json["results"][i]["artistName"].string!)
                        self.trackCensoredNameArray.append(json["results"][i]["trackCensoredName"].string!)
                        self.preViewURLArray.append(json["results"][i]["previewUrl"].string!)
                        self.artWorkUrl100Array.append(json["results"][i]["artworkUrl100"].string!)
                        print("kai")
                        print(json["results"][i]["previewUrl"].string!)
                        print("kai")
                    }
                    
                    //ここでデリゲートメソッドを作成し、他のコントローラに処理をさせる。
                    self.MusicDelegate?.catchData(count: 1)
                    
                } catch  {
                    print("errorが起きました")
                }
                break
            case .failure(_): break
            }
        }
    }
}
