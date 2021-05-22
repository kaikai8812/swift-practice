//
//  ViewController.swift
//  instagram
//
//  Created by ヘパリン類似物質 on 2021/05/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var plofileImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    var urlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //カメラ、アルバム使用許可記述
        let checkModel = CheckModel()
        checkModel.showCheckPermission()
        
        
        
    }

    @IBAction func login(_ sender: Any) {
        
        //匿名ログイン
        
        Auth.auth().signInAnonymously { resut, error in
            
            if error != nil {
                return
            }
            
            let user = resut?.user
            
            //次の画面をインスタンス化
            let selectVC = self.storyboard?.instantiateViewController(identifier: "selectVC") as! SelectRoomViewController
            
            //sendDBModelに引数として送るためにデータ化する。
            let data = self.plofileImageView.image?.jpegData(compressionQuality: 0.01)
            
            //モデルで定義したメソッドを使用
            let sendDBModel = SendDBModel()
            sendDBModel.sendProfileImageData(data: data!)
            
            
            self.navigationController?.pushViewController(selectVC, animated: true)
            
            
        }
    }
    
    
    @IBAction func tapImageView(_ sender: Any) {
        
        showAlert()
        
    }
    
    //カメラを起動するメソッド
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
    
    //アルバムを起動するときのメソッド
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
    
    
    //カメラかアルバムで、画像を選択した際に、選択した画像をどう処理するかを記述
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            if info[.originalImage] as? UIImage != nil{
                
                let selectedImage = info[.originalImage] as! UIImage
                plofileImageView.image = selectedImage
                picker.dismiss(animated: true, completion: nil)
                
            }
            
        }

    //カメラやアルバムの選択をキャンセルした際に、どのような動作をするか
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            picker.dismiss(animated: true, completion: nil)
            
        }
    
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
    //画面をタップした際に、キーボードを終了する。
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            textField.resignFirstResponder()
        }
}

