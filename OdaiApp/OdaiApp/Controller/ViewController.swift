//
//  ViewController.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/19.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    let db1 = Firestore.firestore().collection("Odai").document("6fqTXCag3aCbkQM1RwIZ")
    
    
    
    


}

