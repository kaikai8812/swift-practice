//
//  ShareViewController.swift
//  tiktok
//
//  Created by ヘパリン類似物質 on 2021/05/24.
//

import UIKit
import AVKit
import Photos  //Photosってどこで使うか、要確認

class ShareViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    //editVCから、選択した音楽の情報と、合成した動画URLを取得する
    var captionString = String()
    //音声データも入っているものだと確認済み
    var passedURL = String()
    
    //動画再生用
    var player:AVPlayer?
    var playerController:AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //キーボードに合わせて表示を調節する記述
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        notification.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(passedURL)
        print("kai")
        //完成されたURL（passedURL）を使用して、動画を再生する
        setUPvideoPlayer(url: URL(string: passedURL)!)
    }
    
    
    
    
    //ここの関数、以前学んだ記述方法でやった場合とで、どのような挙動の違いが出るか確認する。
    @objc func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
        }
    }
    
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    //動画再生メソッド
    func setUPvideoPlayer(url:URL){
        //前回までの残っていた設定を全て初期化する？
        //初期化しなかったらどうなるのか、確認すること。
        playerController?.removeFromParent()
        player = nil
        player = AVPlayer(url: url)
        player?.volume = 1.0
        
        view.backgroundColor = .black
        
        //すでに宣言はしているが、メモリを確保するために再度宣言を行う???
        playerController = AVPlayerViewController()
        //ビデオをどのようなサイズ感で行うかを設定
        playerController?.videoGravity = .resizeAspectFill
        //動画再生の位置、大きさをここで指定する
        playerController?.view.frame = CGRect(x: 23, y: 72, width: view.frame.size.width - 100, height: view.frame.size.height - 260)
        playerController?.view.backgroundColor = .green
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
        
        //動画を再生する
        player?.play()
    }
    
    @objc func playerItemDidReachEnd(_ notification:Notification) {
        
        if self.player != nil {
            
            self.player?.seek(to: CMTime.zero)
            self.player?.volume = 1
            self.player?.play()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
    
    
    //動画URLから、アルバムへと保存をする。
    @IBAction func savePhotoLibrary(_ sender: Any) {
        
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(string: self.passedURL)!)
        } completionHandler: { result, error in
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            if result == true {
                print("動画を保存しました！！")
            }
        }
    }
    
    
    @IBAction func share(_ sender: Any) {
    
        //シェアしたいitemは、動画、楽曲の情報、コメント
        //まず、シェアしたいモノをまとめたAny型の配列を作成
        let activityItems = [URL(string: passedURL) as Any, "\(textView.text)\n\(captionString)\n#Swiftアプリ練習用"] as Any
        
        let activityController = UIActivityViewController(activityItems: activityItems as! [Any], applicationActivities: nil)
        
        //ここから下の記述が、どのような変化をもたらすのか、確認する
        activityController.popoverPresentationController?.sourceView = self.view
        activityController.popoverPresentationController?.sourceRect = self.view.frame
        
        self.present(activityController, animated: true, completion: nil)
    }
    
    //トップページへ戻るボタン
    @IBAction func back(_ sender: Any) {
        
        player?.pause()
        player = nil
        //一番最初に戻る記述
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    
    
}
