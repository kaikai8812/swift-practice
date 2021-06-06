//
//  NextViewController.swift
//  TwitterLoginPractice
//
//  Created by ヘパリン類似物質 on 2021/06/06.
//

import UIKit
import FirebaseAuth

class NextViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = Auth.auth().currentUser?.uid
    }

}
