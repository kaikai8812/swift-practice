//
//  WebViewController.swift
//  newsApp
//
//  Created by ヘパリン類似物質 on 2021/05/16.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate {
    
    //プログラムで、webViewを作成する。
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //storyboardを使用していないので、コードで大きさを規定する
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 500)
        view.addSubview(webView)
        
        //保存したurlを取り出して、httpリクエストを送信している。
        let urlString = UserDefaults.standard.object(forKey: "url")
        let url = URL(string: urlString as! String)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        
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
