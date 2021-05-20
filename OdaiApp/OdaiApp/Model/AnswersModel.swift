//
//  AnswersModel.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/19.
//

import Foundation

struct AnswersModel {
    let answers:String
    let userName:String
    let docID:String
    //↓いいね機能を作成する際に追加
    let likeCount:Int
    //キーをstring型で持つ辞書型を宣言 
    let likeFlagDic:Dictionary<String, Any>
}
