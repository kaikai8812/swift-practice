//
//  ViewController.swift
//  CalcApp
//
//  Created by ヘパリン類似物質 on 2021/05/11.
//

import UIKit

//carモデルの設計図をもとに、carModelという実体を作成する。
var carModel = Car()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        carModel.frontWheel = 20
        carModel.rearWheel = 10
        
        
    }


    @IBAction func doAction(_ sender: Any) {
        
        //carModelの設計図内で作成されたメソッド(drive)を呼び出している。
        carModel.drive()
        
        carModel.move(toBack: "後ろ", human: "私", count: 3)
        
        let totalWheels = carModel.plusAndMinus(num1: carModel.frontWheel, num2: carModel.rearWheel)
        
        print("タイヤの合計数は、\(totalWheels)です。")
    }
    
    
    
}

