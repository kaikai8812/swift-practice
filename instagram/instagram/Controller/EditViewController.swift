//
//  EditViewController.swift
//  instagram
//
//  Created by ヘパリン類似物質 on 2021/05/22.
//

import UIKit
import FirebaseAuth

class EditViewController: UIViewController {
    
    //roomの判別のため
    var roomNumber = Int()
    //投稿の画像を受け取るため。
    var passImage = UIImage()
    
    var userName = String()
    
    var userImageString = String()
    
    let screenSize = UIScreen.main.bounds.size
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //キーボード
        NotificationCenter.default.addObserver(self, selector: #selector(EditViewController.keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EditViewController.keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if UserDefaults.standard.object(forKey: "userName") != nil {
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        
            print(userName)
            print("aoyama")
        }
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            userImageString = UserDefaults.standard.object(forKey: "userImage") as! String
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    @objc func keyboardWillShow(_ notification:NSNotification){
        
        let keyboardHeight = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        
        textField.frame.origin.y = screenSize.height - keyboardHeight - textField.frame.height
        sendButton.frame.origin.y = screenSize.height - keyboardHeight - sendButton.frame.height
        
        
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification){
        textField.frame.origin.y = screenSize.height - textField.frame.height
        sendButton.frame.origin.y = screenSize.height - sendButton.frame.height
        //空判定を
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{return}
        
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.transform = transform
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        textField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        if textField.text?.isEmpty == true {
            print("テキストフィールドを入力してください")
            return
        }
        
        //前回のコントローラーから渡ってきた投稿する画像imageを、データ型に変換する。
        let passData = passImage.jpegData(compressionQuality: 0.01)
        
        //sendDBModelをインスタンス化
        let sendDBModel = SendDBModel(userID: String(Auth.auth().currentUser!.uid), userName: userName, comment: textField.text!, userImageString: userImageString, contentImageData: passData!)
        
        //fireStoreへ投稿データを送信するメソッドを呼び出す
        sendDBModel.sendData(roomNumber: String(roomNumber))
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
}
