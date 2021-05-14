//
//  File.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import Foundation

//imagedMOdelは、写真一つに対するデータ処理を任されている
class ImagesModel {
    
    //画像名を取得して、その画像名が人間かそうでないかをフラグによって判定するための機能
    
    let imageText:String
    let answer:Bool
    
    init(imageName:String, correctOrNot:Bool) {
        
        imageText = imageName
        
        answer = correctOrNot
    
    }
    
}
