//
//  ViewController.swift
//  protocol-practice
//
//  Created by ヘパリン類似物質 on 2021/05/13.
//

import UIKit

class ViewController: UIViewController, CatchProtocol {
    
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func goButton(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    
    func catchData(count: Int) {
        label.text = String(count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let nextVC = segue.destination as! NextViewController
            nextVC.delegate = self
        }
    }
}


