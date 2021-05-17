//
//  LoginViewController.swift
//  meigenApp
//
//  Created by ヘパリン類似物質 on 2021/05/16.
//

import UIKit
import FirebaseAuth //twitterログイン用
import NVActivityIndicatorView  

class LoginViewController: UIViewController {
    
    var provider:OAuthProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = OAuthProvider(providerID: TwitterAuthProviderID)
        provider?.customParameters = ["lang" : "ja"]

    }
    
    


    
    @IBAction func twitterLogin(_ sender: Any) {
        provider = OAuthProvider(providerID: TwitterAuthProviderID)  //ここ付近の処理で、twitterでログインするための情報を取得
        provider?.customParameters = ["forcw_login":"true"]
        provider?.getCredentialWith(nil, completion: {  //
            (credential, error) in
            
            //ロード画面を作成する
            let activityView = NVActivityIndicatorView(frame: self.view.bounds, type: .pacman, color: .blue, padding: .none)
            self.view.addSubview(activityView)
            activityView.startAnimating()
            
            //ログイン処理
            Auth.auth().signIn(with: credential!) { result, error in  //ログインができたら、resultに結果が入り、失敗したらerrorに情報が入る。
                
                if error != nil{
                    return
                }
                
                activityView.stopAnimating()
                
                //画面遷移する際に、ログインユーザ情報も一緒に渡す
                
                let viewVC = self.storyboard?.instantiateViewController(identifier: "viewVC") as! ViewController
                viewVC.userName = (result?.user.displayName)!  //次のページに、ログインユーザーの名前を渡す
                self.navigationController?.pushViewController(viewVC, animated: true) //画面遷移
            }
            
        })
    }

   
}
