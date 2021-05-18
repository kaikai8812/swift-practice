//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by ヘパリン類似物質 on 2021/05/18.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate,SendProfileOKDelegete {
    
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    let sendToDBModel = SendToDBModel()
    var urlSting = String()
    
    
    override func viewDidLoad() {
        
        //カメラもしくはアルバムの使用許可
        let checkModel = CheckPermission()
        checkModel.showCheckPermission()
        
        sendToDBModel.sendProfileOKDelegete = self
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func touroku(_ sender: Any) {
        
        //メールアドレスとパスワードとプロフィール写真が空でないかを確認
        if emailTextField.text?.isEmpty != true && passwordTextField.text?.isEmpty != nil, let image = profileImageView.image{
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                //UIimageを、Data型に変換 
                let data = image.jpegData(compressionQuality: 1.0)
                //関数を呼び出し、プロフィール写真をstorageの保存、アプリ内に画像URLを保存
                self.sendToDBModel.sendProfileImageData(data: data!)
            }
        }
    }
    
    //新規登録を押した後に呼ばれるデリゲートメソッド。
    func sendProfileOKDelegete(url: String) {
        
        urlSting = url
        
        if urlSting.isEmpty != true {
            performSegue(withIdentifier: "chat", sender: nil)
        }
    }
    
    
    
    @IBAction func tapImageView(_ sender: Any) {
        
        //カメラもしくはアルバムから、選択をする
        //アラートを出す。
        showAlert()
        
    }
    
    
    //カメラ立ち上げメソッド
    func doCamera(){
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    //アルバム立ち上げメソッド
    
    func doAlbum(){
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        //カメラ利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            let cameraPicker = UIImagePickerController()
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    //アルバム等から選んだ写真をどうするかを記述？
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if info[.originalImage] as? UIImage != nil{
            
            let selectedImage = info[.originalImage] as! UIImage
            profileImageView.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    //アラート
    func showAlert(){
        
        let alertController = UIAlertController(title: "選択", message: "どちらを使用しますか?", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            
            self.doCamera()
            
        }
        let action2 = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
            
        }
        
        let action3 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
 
    
    
}
