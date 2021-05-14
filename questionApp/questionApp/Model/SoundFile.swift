//
//  SoundFile.swift
//  questionApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import Foundation
import AVFoundation //音声ファイル関係

class SoundFile {

    var player:AVAudioPlayer?

    //filename:音声ファイル名,extendionName:拡張子の名前
    func playsound(filename:String, extensionName:String) {

        //再生する音楽ファイルのデータをsoundURLに格納
        let soundURL = Bundle.main.url(forResource: filename, withExtension: extensionName)

        //do-catch文---doの中身でエラーが生じた場合に、catchの中身が動く
        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player!.play()
        } catch {
            print("エラーです！")
        }
    }
}
