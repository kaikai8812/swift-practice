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
    
    //ログアウトボタンの追加
    var logoutBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        //カスタムセルを使用する宣言
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "Cell")  //ここが実際にいるのかどうか、確認すること。
        
        //アプリ内に保存したユーザイメージデータを引っ張ってきて、変数に入れる。
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
        }
        
        if roomName == "" {
            roomName = "ALL"
        }
        
        self.navigationItem.title = roomName
        loadMessages(roomName: roomName)
        
        logoutBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        logoutBarButtonItem.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let registerVC = storyboard?.instantiateViewController(identifier: "registerVC")
        
        do {
                    try Auth.auth().signOut()
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
        
        navigationController?.pushViewController(registerVC!, animated: true)
            print("【+】ボタンが押された!")
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
        return messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //カスタムセルを使用する宣言
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageCell
        //チャットデータが入る配列から、データを取得
        let message = messages[indexPath.row]
        
        //チャット本文を代入
        cell.label.text = message.body
        
        //チャットを送信したユーザによって、imageを表示するかどうかを判定。
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageview.isHidden = false
            cell.rightImageview.sd_setImage(with: URL(string: imageString), completed: nil)
            cell.leftImageView.sd_setImage(with: URL(string: message.imageString), completed: nil)
            
            cell.backView.backgroundColor = .systemTeal
            cell.label.textColor = .black
        
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageview.isHidden = true
            cell.rightImageview.sd_setImage(with: URL(string: message.imageString), completed: nil)
            cell.leftImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            
            cell.backView.backgroundColor = .systemGreen
            cell.label.textColor = .black
        }
        
        return cell
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
