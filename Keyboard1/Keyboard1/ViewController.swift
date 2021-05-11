//
//  ViewController.swift
//  Keyboard1
//
//  Created by ヘパリン類似物質 on 2021/05/12.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate { //UITextFieldDelegateを記述することで、UITextFieldが持っている、delegateメソッドを呼べるようになる。delegateメソッドの仕様書のことを、プロトコルという。

    @IBOutlet weak var logoImageView: UIImageView!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    @IBOutlet weak var passWordTextField: UITextField!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var passWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self  //ここでの記述で、実際にメソッドを使用できるようにする。
//        passWordTextField.delegate = self  //ここでのselfは、ViewControllerのこと。
    }
    
    

    @IBAction func login(_ sender: Any) {
        
        logoImageView.image = UIImage(named: "loginOK")
        
        userNameLabel.text = userNameTextField.text
        passWordLabel.text = passWordTextField.text
        
    }
    
    //画面をタップしたら、キーボードが閉じる
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //returnを押したら、キーボードが閉じる
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  //textFieldのreturnが押された時
        textField.resignFirstResponder()    //textfieldのキーボードを閉じる処理
    }
    
}


