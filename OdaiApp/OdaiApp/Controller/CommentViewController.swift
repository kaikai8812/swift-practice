//
//  CommentViewController.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/20.
//

import UIKit
import Firebase
import FirebaseFirestore

class CommentViewController: UIViewController {

    
    var idString = String()
    var kaitouString = String()
    var userName = String()
    let db = Firestore.firestore()
    
    @IBOutlet weak var kaitouLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
