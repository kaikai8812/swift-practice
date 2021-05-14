//
//  WithOutMP3.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import Foundation

class WithOutMP3: SoundFile {
    
    override func playsound(filename: String, extensionName: String) {
        
        if extensionName == "mp3" {
            print("このファイルは使用できません")
        }
        player?.stop()
        
    }
}
