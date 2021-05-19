//
//  RoomViewController.swift
//  ChatApp
//
//  Created by ヘパリン類似物質 on 2021/05/18.
//

import UIKit
import ViewAnimator
import FirebaseAuth

class RoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var roomNameArray = ["誰でも話そうよ！","20代たまり場！","1人ぼっち集合","地球住み集合！！","好きなYoutuberを語ろう","大学生集合！！","高校生集合！！","中学生集合！！","暇なひと集合！","A型の人！！"]
    var roomImageStringArray = ["0","1","2","3","4","5","6","7","8","9"]

    
    @IBOutlet weak var tableview: UITableView!
    
    //ログアウトボタンの追加
    var logoutBarButtonItem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        tableview.isHidden = true
        
        logoutBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        logoutBarButtonItem.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableview.isHidden = false
        
//        let animation = AnimationType.from(direction: .top, offset: 300)
//        UIView.animate(views: tableView.visibleCells, animations: [animation],delay: 0,duration: 2)
        
    }
    
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
            print("【+】ボタンが押された!")
        do {
                    try Auth.auth().signOut()
            
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomNameArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath)
        
        //デフォルトのセル表示を利用する。
        cell.imageView?.image = UIImage(named: roomImageStringArray[indexPath.row])
        cell.textLabel?.text = roomNameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "roomChat", sender: indexPath.row)  //ここで飛ばしたsenderは、prepareForSegueのsenderに入る！
        
    }
    
    //ChatViewControllerに処理を渡す前に、ここのしょりが行われ、room名を特定する。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let roomChatVC = segue.destination as! ChatViewController
        
        roomChatVC.roomName = roomNameArray[sender as! Int]
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

