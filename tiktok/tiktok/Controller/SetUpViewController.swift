//
//  SetUpViewController.swift
//  tiktok
//
//  Created by ヘパリン類似物質 on 2021/05/23.
//

import UIKit
import SwiftyCam  //動画撮影用？
import AVFoundation  //多分、動画再生用
import MobileCoreServices

//親クラスを、SwiftyCamViewControllerに変更している。
class SetUpViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate  {
    
    
    
    var videoURL:URL?
    
    //buttonのカスタムクラス（プロパティ）にSwiftyRecordButtonを設定した！
    //Viewフォルダにあるファイルのおかげで、使用できるようになっている。
    
    @IBOutlet weak var captureButton: SwiftyRecordButton!
    
    @IBOutlet weak var flipCameraButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shouldPrompToAppSettings = true
        cameraDelegate = self  //デリゲートメソッドの委任
        maximumVideoDuration = 20.0  //録画可能時間の設定
        shouldUseDeviceOrientation = false //cameraの角度の設定？
        allowAutoRotate = false   //cameraの角度の設定？
        audioEnabled = false      //録画と同時に、録音も行うかの設定
        captureButton.delegate = self  //
        captureButton.buttonEnabled = true
        swipeToZoomInverted = true  //スワイプで、ズームができるかどうか
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func openAlbum(_ sender: Any) {
        
        //動画のみが選択できるアルバムを起動させる.
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.mediaTypes = ["public.movie"]
        
        //編集を許可
        imagePickerController.allowsEditing = true
        
        //設定したImagePickerをpresentで立ち上げる
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //立ち上がっているpickerをキャンセルしたときの動作を記述するデリゲートメソッド
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //立ち上がっているpickerが、このpicker変数に入ってくる。
        picker.dismiss(animated: true, completion: nil)
    }
    
    //pickerで動画を選んだ後に行われるデリゲートメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //選択した動画の情報が、infoに入ってくる
        let imageURL = info[.imageURL] as! URL
        videoURL = imageURL
        
        //pickerを閉じる
        picker.dismiss(animated: true, completion: nil)
        
        //値を渡しながら画面を遷移
        
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditVC" ) as! EditViewController
        
        editVC.url = videoURL
        
        self.navigationController?.pushViewController(editVC, animated: true)
        
        
        
    }
    
    //以下は、SwiftyCumを使用する上での必要なメソッド
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureButton.delegate = self
    }
    
    func swiftyCamSessionDidStartRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did start running")
        captureButton.buttonEnabled = true
    }
    
    func swiftyCamSessionDidStopRunning(_ swiftyCam: SwiftyCamViewController) {
        print("Session did stop running")
        captureButton.buttonEnabled = false
    }
    
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didBeginRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did Begin Recording")
        captureButton.growButton()
        hideButtons()
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishRecordingVideo camera: SwiftyCamViewController.CameraSelection) {
        print("Did finish Recording")
        captureButton.shrinkButton()
        showButtons()
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFinishProcessVideoAt url: URL) {
        
        //ここで撮影後生成されたURLが入っていくる
        print(url.debugDescription)
        
        //値を渡しながら画面遷移
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editVC = storyboard.instantiateViewController(withIdentifier: "EditVC") as! EditViewController
        videoURL = url
        editVC.url = videoURL
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        print("Did focus at point: \(point)")
        focusAnimationAt(point)
    }
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
        let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didChangeZoomLevel zoom: CGFloat) {
        print("Zoom level did change. Level: \(zoom)")
        print(zoom)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didSwitchCameras camera: SwiftyCamViewController.CameraSelection) {
        print("Camera did change to \(camera.rawValue)")
        print(camera)
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFailToRecordVideo error: Error) {
        print(error)
    }
    
    @IBAction func cameraSwitchTapped(_ sender: Any) {
        switchCamera()
    }
    
    
    func hideButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flipCameraButton.alpha = 0.0
        }
    }
    func showButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flipCameraButton.alpha = 1.0
        }
    }
    
    
    func focusAnimationAt(_ point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "focus"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }) { (success) in
                focusView.removeFromSuperview()
            }
        }
    }
    
    
    
}

