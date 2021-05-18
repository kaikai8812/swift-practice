//
//  ChatViewController.swift
//  ChatApp
//
//  Created by ヘパリン類似物質 on 2021/05/18.
//

import UIKit
import Firebase
import SDWebImage

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var roomName = String()
    var imageString = String()
    let db = Firestore.firestore()
    
    //構造体が入る配列は、このように指定する・
    var messages:[Message] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //アプリ内に保存したユーザイメージデータを引っ張ってきて、変数に入れる。
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
        }
        
        if roomName == "" {
            roomName = "ALL"
        }
        
        self.navigationItem.title = roomName
    }
    
    func loadMessages(roomName:String) {
        db.collection(roomName).order(by: "date").addSnapshotListener { snapShot, error in
            
            self.messages = []
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()  //これで、保存されているデータの各値の情報が辞書型で取得できるようになった
                    
                    //各変数に、保存されているデータを種類別に保存
                    if let sender = data["sender"] as? String, let body = data["body"] as? String, let imageString = data["imageString"] as? String {
                        
                        //構造体型のデータをインスタンス化
                        let newMessage = Message(sender: sender, body: body, imageString: imageString)
                        
                        self.messages.append(newMessage)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            
                        }
                        
                    }
                    
                }
                
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    @IBAction func send(_ sender: Any) {
    
        if let messageBody = messageTextField.text, let sender = Auth.auth().currentUser?.email {
            
            //FireStoreにチャットデータを送信する。保存キーをルーム名としつつ、（送信者、チャット内容、ユーザ画像、時刻）
            db.collection(roomName).addDocument(data: ["sender":sender, "body":messageBody, "imageString":imageString, "date": Date().timeIntervalSince1970]) { error in
                
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                }
            }
        }
    }
    
    
}
