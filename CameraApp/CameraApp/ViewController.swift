//
//  ViewController.swift
//  CameraApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import UIKit
import Photos

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var backImageView: UIImageView!
    

    //チェックモデルのインスタンス化
    var checkPermission = CheckPermisson()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPermission.checkCamera()
        
    }

    
    
    
    @IBAction func camera(_ sender: Any) {
        
        let sourceType:UIImagePickerController.SourceType = .camera
        createImagePicker(sourcetype: sourceType)
        
    }
    
    @IBAction func album(_ sender: Any) {
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        createImagePicker(sourcetype: sourceType)
        
    }
    @IBAction func share(_ sender: Any) {
        
        let text = "hello!!"
        //データを圧縮する
        let image =  backImageView.image?.jpegData(compressionQuality: 0.5)
        let item = [text, image] as [Any]
        let activityVC = UIActivityViewController(activityItems: item, applicationActivities: nil)
        //self.presentで、何かしらの動作を立ち上げるタイミング
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
    //引数に立ち上がるアプリ（カメラやアルバム）を渡すことで、そのアプリを立ち上げてくれるメソッド
    func createImagePicker(sourcetype:UIImagePickerController.SourceType){
        
        let cameraPicker = UIImagePickerController()
        cameraPicker.sourceType = sourcetype
        cameraPicker.delegate = self
        cameraPicker.allowsEditing = true
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    //アルバム（カメラ）のキャンセルボタンがタップされた時、画面を終わらす
    //デリゲートメソッド
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil) //ここでのpickerは、デリゲートによって、開かれているUIImagePickerControllerが自動的に指定されている。
    }
    
    //アルバム（カメラ）で撮影もしくは選択されたデータを、どのように処理をするかのデリケードメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //もし取り扱うデータ(info[.editedImage] as? UIImage)が存在するならば、処理を行う。
        if let pickerImage = info[.editedImage] as? UIImage{
            backImageView.image = pickerImage
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

