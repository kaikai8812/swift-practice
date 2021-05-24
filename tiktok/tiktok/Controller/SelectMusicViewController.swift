//
//  SelectViewController.swift
//  tiktok
//
//  Created by ヘパリン類似物質 on 2021/05/24.
//

import UIKit
import SDWebImage
import AVFoundation
import SwiftVideoGenerator //音声と動画を合成する役割

class SelectMusicViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var musicModel = MusicModel()
    var player = AVAudioPlayer()
    //音楽と動画を合成した動画URLを受け取る変数
    var videoPath = String()
    //前画面から、動画URLを受け取る
    var passedURL:URL?
    
    //遷移元から処理を受け取るクロージャのプロパティを用意
    var resultHandler:((String,String,String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self

    }
    
    //音楽を検索する際に利用
    
    
    @IBAction func searchButton(_ sender: Any) {
        refleshData()
    }
    
    func refleshData()  {
        
        if searchTextField.text?.isEmpty != true {
            
            let urlString = "https://itunes.apple.com/search?term=\(String(describing:searchTextField.text!))&entity=song&country=jp"
            
            //パソコンが読める文字列に変換している。API公式サイトに、URLをエンコードした文字列を渡してね、と書いてあるためこのようにしている。
            let encodeUrlString:String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            //モデルメソッドを使用して、検索に該当するデータを取得し、配列を準備する。
            musicModel.setData(resultCount: 50, encodeUrlString: encodeUrlString)
            //キーボードを閉じる
            searchTextField.resignFirstResponder()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicModel.artistNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //cell内の要素をタグで管理
        let artWorkImageView = cell.viewWithTag(1) as! UIImageView
        let musicNameLabel = cell.viewWithTag(2) as! UILabel
        let artistNameLabel = cell.viewWithTag(3) as! UILabel
        
        //JSON解析で得たデータを、cell要素に反映
        artWorkImageView.sd_setImage(with: URL(string: musicModel.artWorkUrl100Array[indexPath.row]), completed:nil)
        musicNameLabel.text = musicModel.trackCensoredNameArray[indexPath.row]
        artistNameLabel.text = musicModel.artistNameArray[indexPath.row]
        
        
        //favボタンを、プログラムで作成(選択した音楽と、動画を合成して、EditViewControllerに返す。)
        let favButton = UIButton(frame: CGRect(x: 293, y: 33, width: 53, height: 53))
        favButton.setImage(UIImage(named: "play"), for: .normal) //ここのnormal、変えるとどうなるかをあとで確認
        favButton.addTarget(self, action: #selector(favButtonTap(_:)), for: .touchUpInside)
        favButton.tag = indexPath.row
        cell.contentView.addSubview(favButton)
        
        //プレビューボタン（音楽再生）をプログラムで作成
        let playButton = UIButton(frame: CGRect(x: 16, y: 10, width: 100, height: 100))
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTap(_:)), for: .touchUpInside)
        playButton.tag = indexPath.row
        return cell
        
    }
    
    
    @objc func favButtonTap(_ sender:UIButton) {
        
        //音声が流れていたら、止める
        
        if player.isPlaying == true {
            player.stop()
        }
        
        //動画と音声を合成する。合成中は、一定時間がかかるため、その間はロード画面を表示させる。
        
        //ロード画面を表示する
        LoadingView.lockView()
        
        //動画と音声を合成する
        VideoGenerator.fileName = "newAudioMovie"
        VideoGenerator.current.mergeVideoWithAudio(videoUrl: passedURL!, audioUrl: URL(string: musicModel.preViewURLArray[sender.tag])!) { result in
            
            //合成が終了したら、ロード画面を終了する
            LoadingView.unlockView()
            
            //合成が成功したかどうかでswitch文を使用する。
            switch result{
            
            case .success(let url):  //ここのurlに、合成した音楽付きURLが入る
                
                self.videoPath = url.absoluteString
                if let handler = self.resultHandler{
                    
                    handler(self.videoPath, self.musicModel.artistNameArray[sender.tag], self.musicModel.trackCensoredNameArray[sender.tag] )
                    
                }
                
                self.dismiss(animated: true, completion: nil)
            
            case .failure(let error):
                print(error)
            }
            
        }
    
        
    }
    
    //プレビューボタンをタップした際に行う処理を記述する
    //senderを用いることで、押されたボタン（UIButton）の情報がsenderに渡る。
    //このことによって、別のスコープで定義したモノ（今回はtag番号）を使用して、処理に利用することができる。
    @objc func playButtonTap(_ sender:UIButton) {
        
        if player.isPlaying == true {
            player.stop()
        }
        
        //タップしたセルのindexpath.rowを、senderを使用してこっちでも使用している。
        let url = URL(string:musicModel.preViewURLArray[sender.tag])
        downLoadMusicURL(url: url!)
    }

    //引数の音楽を再生する関数
    //途中でどんな処理を行なっているのか等、確認する。
    func downLoadMusicURL(url:URL) {
        
        var downLoadTask:URLSessionDownloadTask
        downLoadTask = URLSession.shared.downloadTask(with: url, completionHandler: { url, response, error in
         
            print(url!)
            self.play(url: url!)
        })
        //タスクを再開するために記述。必要はないかも？？
        downLoadTask.resume()
    }
    
    //音楽を再生する関数
    func play(url:URL){
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
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
