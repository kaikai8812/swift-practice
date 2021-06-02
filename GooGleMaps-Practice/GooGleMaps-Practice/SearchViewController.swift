//
//  SearchViewController.swift
//  GooGleMaps-Practice
//
//  Created by ヘパリン類似物質 on 2021/06/02.
//

import UIKit

class SearchViewController: UIViewController {

    
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    
    @IBAction func button(_ sender: Any) {
        
        let mapVC = storyboard?.instantiateViewController(identifier: "mapVC") as! MapViewController
        
        mapVC.address = textField.text!
        
        navigationController?.pushViewController(mapVC, animated: true)
        
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
