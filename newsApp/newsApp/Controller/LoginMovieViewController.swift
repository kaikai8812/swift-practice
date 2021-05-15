//
//  LoginMovieViewController.swift
//  newsApp
//
//  Created by ヘパリン類似物質 on 2021/05/15.
//

import UIKit
import AVFoundation  //動画など、さまざまなものがつかえるようになる。

class LoginMovieViewController: UIViewController {
    
    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //動画ファイルの情報を、playerに格納
        let path = Bundle.main.path(forResource: "start", ofType: "mov")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //AVPlayer用のレイヤーを作成する。
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        //ビデオをどのように表示するか
        playerLayer.videoGravity = .resizeAspectFill
        //何回ビデオを再生するか。
        playerLayer.repeatCount = 0
        //上にログインボタンが来る予定なので、奥に配置する
        playerLayer.zPosition = -1
        //レイヤーをviewに入れる場合は、insertを使用する
        view.layer.insertSublayer(playerLayer, at: 0)
        
        //ビデオを繰り返し再生するための記述
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main){(_) in
            
            self.player.seek(to: .zero)
            self.player.play()
        }
        self.player.play() //まず最初に再生しないといけない。
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションバーを消す
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func login(_ sender: Any) {
        //画面を離れる時に、動画をストップする
        player.pause()
    }
    

}
