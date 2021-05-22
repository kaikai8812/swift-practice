//
//  TimeLineViewController.swift
//  instagram
//
//  Created by ヘパリン類似物質 on 2021/05/22.
//

import UIKit
import Firebase
import Photos
import ActiveLabel
import SDWebImage

class TimeLineViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    //SelectRoomViewから、roomnumberは取得済み
    var roomNumber = Int()
    
    var loadDBModel = LoadDBModel()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        loadDBModel.loadContents(roomnumber: String(roomNumber))
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadDBModel.dataSets.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //プロフィールイメージを設定
        let profileImageView = cell.contentView.viewWithTag(1) as! UIImageView
        profileImageView.sd_setImage(with: URL(string: loadDBModel.dataSets[indexPath.row].profileImage), completed: nil)
        
        //ユーザ名を設定
        let userNameLabel = cell.contentView.viewWithTag(2) as! UILabel
        userNameLabel.text = loadDBModel.dataSets[indexPath.row].userName
        
        //投稿画像を設定
        let contentImageView = cell.contentView.viewWithTag(3) as! UIImageView
        contentImageView.sd_setImage(with: URL(string: loadDBModel.dataSets[indexPath.row].contentImage), completed: nil)
        
        //コメントを設定(ActiveLabelを用いて、ハッシュタグが使えるようにする。)
        let commetLabel = cell.contentView.viewWithTag(4) as! ActiveLabel   //as! ActiveLabelをつける！
        commetLabel.enabledTypes = [.hashtag]  //使用するタグをどのようなものにするか確認
        commetLabel.text = "\(loadDBModel.dataSets[indexPath.row].comment)"
        
        //ハッシュタグをタップした際に行う動作を記述
        commetLabel.handleHashtagTap { (hashtag) in
            
            print(hashtag)
            
        }
        
        return cell
        
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    @IBAction func openCamera(_ sender: Any) {
        
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
            
            //EditVCに、選択した画像とroomNumberを渡して、画面遷移を行う。
            let editVC = self.storyboard?.instantiateViewController(identifier: "editVC") as! EditViewController
            editVC.roomNumber = roomNumber
            editVC.passImage = selectedImage
            self.navigationController?.pushViewController(editVC, animated: true)

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
    
    
}
