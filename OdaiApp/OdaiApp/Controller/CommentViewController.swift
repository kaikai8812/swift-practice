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
    
    //キーボードの自動位置調整のため。
    let screenSize = UIScreen.main.bounds.size
    
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
        
        kaitouLabel.text = kaitouString
        
        if UserDefaults.standard.object(forKey: "userName") != nil{
            userName = UserDefaults.standard.object(forKey: "userName") as! String
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //戻るボタンが必要になるので、ナビゲーションバーを表示させる。
        self.navigationController?.isNavigationBarHidden = false
        loadData()
    }
    
    //テキストフィールド等が自動で上にあがるメソッド
    @objc func keyboardWillShow(_ notification:NSNotification){
        
        let keyboardHeight = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        
        textField.frame.origin.y = screenSize.height - keyboardHeight - textField.frame.height
        sendButton.frame.origin.y = screenSize.height - keyboardHeight - sendButton.frame.height
    }
    
    
    //テキストフィールド等が自動で下に下がるメソッド
    @objc func keyboardWillHide(_ notification:NSNotification){
        
        textField.frame.origin.y = screenSize.height - textField.frame.height
        
        sendButton.frame.origin.y = screenSize.height - sendButton.frame.height
        
        
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{return}
        
        UIView.animate(withDuration: duration) {
            
            let transform = CGAffineTransform(translationX: 0, y: 0)
            self.view.transform = transform
            
        }
        
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
                self.dataSets.reverse()
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
        
        //セルの選択ハイライト表示を消す方法
        cell.selectionStyle = .none

        return cell
        
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        
        if textField.text == nil {
            return
        }
        
        db.collection("Answers").document(idString).collection("comment").document().setData(["userName" : userName as Any, "comment": textField.text as Any, "postDate": Date().timeIntervalSince1970])
        
        //textFieldの中身を空にする
        textField.text = ""
        
        //textFieldに書き込むことができるキーボードが閉じる！
        textField.resignFirstResponder()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    
    
    
    
    
}
