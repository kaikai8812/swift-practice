//
//  LoginViewController.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/19.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ナビゲーションバーを隠す。
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    @IBAction func done(_ sender: Any) {
        //ログイン処理を行う
        login()
    }
    
    func login(){
        
        Auth.auth().signInAnonymously { result, error in
            
            let user = result?.user
            print(user)
            //登録した時点で、ユーザの名前をアプリ内に保存
            UserDefaults.standard.set(self.textField.text, forKey: "userName")
            
            //画面遷移
            let viewVC = self.storyboard?.instantiateViewController(identifier: "viewVC") as! ViewController
            self.navigationController?.pushViewController(viewVC, animated: true)
        }
        
    }

}
