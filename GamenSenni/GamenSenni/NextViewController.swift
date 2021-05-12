//
//  NextViewController.swift
//  GamenSenni
//
//  Created by ヘパリン類似物質 on 2021/05/12.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label2.text = String(count2)

        // Do any additional setup after loading the view.
    }
    
    var count2 = 0 //遷移前の画面からデータを受け取る用の変数を準備
    

    @IBAction func back(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var label2: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
