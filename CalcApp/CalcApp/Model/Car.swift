//
//  Car.swift
//  CalcApp
//
//  Created by ヘパリン類似物質 on 2021/05/11.
//

import Foundation

class Car{
    
    var frontWheel = 0
    var rearWheel = 0
    
    //rubyでいう、initialize,初期化を表す。
    init(){
        
        frontWheel = 2
        rearWheel = 2
        
    }

    //func は、　機能を表す。
    func drive(){
        
        print ("運転開始")
        
        print("前輪: \(frontWheel)")
        print("後輪: \(rearWheel)")
        
    }
    
    //引数を与える、メソッドの記述方法 rubyとは違い、データ型を指定する必要がある。
    func move(toBack:String, human:String, count:Int){
        print("\(toBack),\(human),\(count) ")
    }
    
    
    func plusAndMinus(num1:Int, num2:Int) -> Int{
        return num1 + num2
    }
    
    
    }
