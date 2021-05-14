//
//  ChangeColor.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import Foundation
import UIKit  //viewのデザイン関係の処理を行うので、UIKitを追加する。

class ChangeColor {
    
    
    func changeColor(topR:CGFloat,topG:CGFloat,topB:CGFloat,topAlpha:CGFloat,bottomR:CGFloat,bottomG:CGFloat,bottomB:CGFloat,bottomAlpha:CGFloat) -> CAGradientLayer{
        
        //UIColor型で、色の情報を持ったデータを作成できる
        let topColor = UIColor(red: topR, green: topG, blue: topB, alpha: topAlpha)
        let bottomColor = UIColor(red: bottomR, green: bottomG, blue: bottomB, alpha: bottomAlpha)
        
        let gradientColor = [topColor.cgColor, bottomColor.cgColor]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        
        return gradientLayer
        
    }
    
    
}

