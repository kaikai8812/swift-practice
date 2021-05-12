//
//  ViewController.swift
//  WKWebView
//
//  Created by ヘパリン類似物質 on 2021/05/12.
//

import UIKit
import WebKit //webKitが使用できるように、ライブラリをインポート

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView = WKWebView()  //WebKitをインポートしているから、このクラスが使える。
    
    @IBOutlet weak var indicater: UIActivityIndicatorView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        indicater.isHidden = true  //indicaterを隠している
        
        //webViewの配置、大きさを指定。
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - toolBar.frame.size.height)
        
        //大きさを指定したwebViewを、view(表示される領域)に追加。
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        //URLをロードする
        //まず、string型のURlを、URL型のデータにキャストする。
        let url = URL(string: "https://aoyama-portfolio.work/" )
        //準備したURlを、URLrequestにする。
        let request = URLRequest(url: url!)
        //webViewが、URLをロードする。
        webView.load(request)
        
        //webViewが読み込まれた後は、indicatorが配置されているviewは階層的に下の方に位置し、見えなくなってしまうので、ここで階層を上に上げることで見えるようにしている。
        indicater.layer.zPosition = 2
    }
    
    //webViewの読み込みが終了したときに発動する、デリゲートメソッド
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicater.isHidden = true
        indicater.stopAnimating()
    }
    
    //webViewの読み込みが開始された時のデリゲートメソッド
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        indicater.isHidden = false
        indicater.startAnimating()
    }
    

    @IBAction func back(_ sender: Any) {
        webView.goBack()
    }
    
    
    
    
    @IBAction func go(_ sender: Any) {
        webView.goForward()
    }
    
    
}

