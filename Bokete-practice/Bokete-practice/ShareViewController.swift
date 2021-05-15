//
//  NextViewController.swift
//  Bokete-practice
//
//  Created by ヘパリン類似物質 on 2021/05/15.
//

import UIKit

class ShareViewController: UIViewController {
    
    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()
    
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        resultImageView.image = resultImage
        commentLabel.text = commentString
        print("aoyama")
        print(commentString)
        //ラベルサイズにあわして、文字を自動的に調整する
        commentLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    @IBAction func share(_ sender: Any) {
        
        //スクリーンショットを撮影する
        takeScreenShot()
        
        //アクティビティビューに乗っけてシェアする。
        let items = [screenShotImage] as [Any] //as[Any]をつけることで、どの型でも入る配列ということを表している。
        
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //書き方は割と固定されている。スクリーンショットの撮り方。
    func takeScreenShot() {
    
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
    
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
