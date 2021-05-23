//
//  EditViewController.swift
//  tiktok
//
//  Created by ヘパリン類似物質 on 2021/05/24.
//

import UIKit
import AVKit //これを用いて、バックに動画のプレビューを再生する。

class EditViewController: UIViewController {

    var url:URL? = nil
    
    //ライブラリのAVkitがあると使用可能。動画再生用にインスタンス化
    var playerController:AVPlayerViewController?
    var player:AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setUPvideoPlayer(url: url!)
        
    }
    
    
    //引数の動画URLを再生できるように、AVPlayerViewControllerを定義し、動画を再生する関数
    func setUPvideoPlayer(url:URL){
        //前回までの残っていた設定を全て初期化する？
        //初期化しなかったらどうなるのか、確認すること。
        playerController?.removeFromParent()
        player = nil
        view.backgroundColor = .black
        
        //すでに宣言はしているが、メモリを確保するために再度宣言を行う???
        playerController = AVPlayerViewController()
        //ビデオをどのようなサイズ感で行うかを設定
        playerController?.videoGravity = .resizeAspectFill
        //動画再生の位置、大きさをここで指定する
        playerController?.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 100)
        //再生のシークバー的なやつだと思われる。あとでtrueにして確認
        playerController?.showsPlaybackControls = false
        //plawerControllerが持つobjectであるplayerの設定をしている。
        playerController?.player = player
        //UIviewControllerに対して、plawerControllerという子を追加する
        self.addChild(playerController!)
        //UIviewControllerのviewに、playerControllerのviewを追加する。
        self.view.addSubview((playerController?.view)!)
        
        //動画のリピート機能を作成する
        
        //あるタイミングで使用したいメソッドがある場合は、NotificationCenterを使用すると良い。
        //selecter = 行うメソッド name = どうゆうタイミングか object:対象は何なのか　を、指定する。
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        
        
        //キャンセルボタンを、プログラムで作成する
        //UIButtonのインスタンス化と、位置、大きさを作成する。
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        //作成したUIButtonに、imageをセットする
        cancelButton.setImage(UIImage(named: "cancel"), for: UIControl.State())
        //ボタンをタップした際のアクションを決める
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        //Viewに貼る
        view.addSubview(cancelButton)
        
        
        //動画を再生する
        player?.play()
    }
    
    //キャンセルボタンを押したときに呼ばれるメソッド
    @objc func cancel() {
        
        //画面を戻る
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //動画の再生時間が終わったときに、呼ばれるメソッド
    @objc func playerItemDidReachEnd() {
        self.player?.seek(to: CMTime.zero)
        self.player?.volume = 1
        self.player?.play()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
