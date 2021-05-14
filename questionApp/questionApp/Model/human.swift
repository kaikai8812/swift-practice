//
//  human.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import Foundation

class Human:Animal {
    
    override func breath() {
        super.breath()  //継承元のメソッドは呼び出さないと動かない。
        profile()
    }
    
    func profile(){
        print("私は凱です。")
    }
}
