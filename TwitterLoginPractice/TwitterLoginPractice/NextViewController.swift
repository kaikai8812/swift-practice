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
        userName.text = Auth.auth().currentUser?.displayName
  
    }
    
    
    let URL:URL = (Auth.auth().currentUser?.photoURL)!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var profile: UILabel!
    
    
}
