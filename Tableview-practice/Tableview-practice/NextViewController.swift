//
//  NextViewController.swift
//  Tableview-practice
//
//  Created by ヘパリン類似物質 on 2021/05/12.
//

import UIKit


class NextViewController: UIViewController {
    
    
    //viewcontrollerから値を受け取るために箱（変数）を用意する。
    var toDoString = String()
    

    @IBOutlet weak var toDoLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false

        //受け取ったデータを、代入
        toDoLabel.text = toDoString
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        navigationController?.isNavigationBarHidden = true
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
