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
    
    var player = AVAudioPlayer()
    var videoPath = String()
    //前画面から、動画URLを受け取る
    var passedURL:URL?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self

    }
    
    func refleshData()  {
        
        if searchTextField.text?.isEmpty != true {
            
            let urlString = "https://itunes.apple.com/search?term=\(String(describing:searchTextField.text!))&entity=song&country=jp"
            
            //パソコンが読める文字列に変換している。API公式サイトに、URLをエンコードした文字列を渡してね、と書いてあるためこのようにしている。
            let encodeUrlString:String = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
