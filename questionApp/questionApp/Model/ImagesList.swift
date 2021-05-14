//
//  ImagesList.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import Foundation

class ImagesList {
    
    //ImagesModelで定義されたデータが入る配列を定義
    var list = [ImagesModel]()
    
    init(){
        
        list.append(ImagesModel(imageName:"1", correctOrNot:false))
        list.append(ImagesModel(imageName:"2", correctOrNot:false))
        list.append(ImagesModel(imageName:"3", correctOrNot:false))
        list.append(ImagesModel(imageName:"4", correctOrNot:true))
        list.append(ImagesModel(imageName:"5", correctOrNot:false))
        list.append(ImagesModel(imageName:"6", correctOrNot:true))
        list.append(ImagesModel(imageName:"7", correctOrNot:true))
        list.append(ImagesModel(imageName:"8", correctOrNot:false))
        list.append(ImagesModel(imageName:"9", correctOrNot:true))
        
    }
    
}
