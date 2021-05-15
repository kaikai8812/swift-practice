//
//  ViewController.swift
//  Bokete-practice
//
//  Created by ヘパリン類似物質 on 2021/05/15.
//

import UIKit
import Alamofire  //httpリクエストを送るため等
import SwiftyJSON //JSON型のデータを扱えるようにする。
import SDWebImage //web上にある画像データを、扱えるようにする。
import Photos



class ViewController: UIViewController {
    
    var count = 0
    

    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization{(states) in
            switch(states){
            case .authorized: print("authorized");break
            case .notDetermined: print("notdetermined");break
            case .restricted: print("restricted");break
            case .denied: print("denied");break
            case .limited: print("limited");break
            @unknown default: print("break");break
            }
        }
        
        getImages(keyword: "funny")
    }
    
    
    
    @IBAction func nextOdai(_ sender: Any) {
        count = count + 1
        
        if searchTextField.text == ""{
            getImages(keyword: "funny")
        }else{
            
            getImages(keyword: searchTextField.text!)
        }
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        count = 0
        
        if searchTextField.text == ""{
            getImages(keyword: "funny")
        }else{
            
            getImages(keyword: searchTextField.text!)
        }
    }
    
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "share", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
           let shareVC = segue.destination as! ShareViewController
            
            shareVC.commentString = commentTextView.text
            shareVC.resultImage = odaiImageView.image!
        }
    }
    
    
    
    
    //検索キーワードの値をもとに、画像を持ってくる
    //pixabay.com

    func getImages(keyword:String) {
        
        //API KEY = 21627028-4410cfec5802ee561c2e73b69
        
        let url = "https://pixabay.com/api/?key=21627028-4410cfec5802ee561c2e73b69&q=\(keyword)"

        
        //Alamofireを用いて、httpリクエストをする
        AF.request(url).responseJSON{(responce) in
            switch responce.result{
            
            case .success:
                //json変数に、受け取ったデータをJSON型で取得
                let json:JSON = JSON(responce.data as Any)
                //受け取ったJSONデータ内のWebFormatURLの文字列を取得する。
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                //もし、JSONファイルの中にデータがなくなったら(3個しかない検索ワードの時に、4個目を取得し用途した場合)
                if imageString == nil {
                    self.count = 0
                    imageString = json["hits"][self.count]["webformatURL"].string
                }
                //SDwebImageの仕組みを使って、imageViewに画像URl(webformatURL)を反映させる
                self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
            case .failure(let error):
                print(error)
            }
        }
        
        //帰ってきたhttpレスポンスにあるJsonファイルを解析する
        //imageView.imageに貼り付ける。
        
    }

}

