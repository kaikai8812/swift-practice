//
//  ViewController.swift
//  TwitterLoginPractice
//
//  Created by ヘパリン類似物質 on 2021/06/06.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController, AuthUIDelegate {
    
    var provider = OAuthProvider(providerID: "twitter.com")

    var auth = AuthUIDelegate.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider.customParameters = ["lang": "ja"]
        
    }

    @IBAction func login(_ sender: Any) {
        
        provider.getCredentialWith(nil) { credential, error in

            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if credential != nil {
                
                
                
                Auth.auth().signIn(with: credential!) { authResult, error in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                }
            }
        }
        
        performSegue(withIdentifier: "next", sender: nil)
        
        
    }
    
}

