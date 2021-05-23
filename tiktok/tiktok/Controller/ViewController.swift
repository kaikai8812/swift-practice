//
//  ViewController.swift
//  tiktok
//
//  Created by ヘパリン類似物質 on 2021/05/23.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }


}
