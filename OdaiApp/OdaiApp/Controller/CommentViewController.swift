//
//  CommentViewController.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/20.
//

import UIKit
import Firebase
import FirebaseFirestore

class CommentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    

    
    var idString = String()
    var kaitouString = String()
    var userName = String()
    let db = Firestore.firestore()
    
    var dataSets = [CommentModel]()
    
    @IBOutlet weak var kaitouLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if UserDefaults.standard.object(forKey: "userName") != nil{
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //戻るボタンが必要になるので、ナビゲーションバーを表示させる。
        self.navigationController?.isNavigationBarHidden = false
        loadData()
    }
    
    //コメントのデータを、fireStoreから取ってくる処理
    func loadData() {
        db.collection("Answers").document(idString).collection("comment").order(by: "postDate").addSnapshotListener { snapShot, error in
            
            self.dataSets = []
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
            
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if let userName = data["userName"] as? String, let comment = data["comment"] as? String, let postDate = data["postDate"] as? Double {
                        
                        let commentModel = CommentModel(userName: userName, comment: comment, postDate: postDate)
                        
                        self.dataSets.append(commentModel)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        tableView.rowHeight = 200
        let commentLabel = cell.contentView.viewWithTag(1) as! UILabel
        commentLabel.numberOfLines = 0
        commentLabel.text = "\(dataSets[indexPath.row].userName)君の\n\(self.dataSets[indexPath.row].comment)"
        
        return cell
        
        
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        
        db.collection("Answers").document(idString).collection("comment").document().setData(["userName" : userName as Any, "comment": textField.text as Any, "postDate": Date().timeIntervalSince1970])
    }
    
    

   

}
