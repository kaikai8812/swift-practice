//
//  FeedViewController.swift
//  meigenApp
//
//  Created by ヘパリン類似物質 on 2021/05/17.
//

import UIKit
import BubbleTransition //画面遷移の際のアニメーション
import Firebase
import FirebaseFirestore  //いらない説濃厚
import SDWebImage        //画像のURLを使用するために使用
import ViewAnimator     //???

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var interactiveTransition:BubbleInteractiveTransition!
    
    let db = Firestore.firestore()
    
    var feeds:[Feeds] = []  //モデルと、構造体の違いとは？？
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //カスタムセルを作成　セルを別ファイルで自分で作成した場合は、表示させたいUIViewControllerで定義する必要がある。
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "feedcell")
        
        tableView.separatorStyle = .none  //テーブルの枠線を消す。
        
        loadData()

    }
    //firestoreから、データを受信する。
    func loadData(){
        
        //投稿されたものを受信する,order(by: "createAt")で、古い順にデータを取得している事になる。
        db.collection("feed").order(by: "createAt").addSnapshotListener { snapShot, error in
            
            self.feeds = []
            
            //エラーがあった場合、終了
            if error != nil{
                print(error.debugDescription)
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                //保存されているデータの数だけ繰り返す。
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    //もしデータがしっかり保存されていたら
                    if let userName = data["userName"] as? String, let quote = data["quote"] as? String, let photoURL = data["photoURL"] as? String{
                        
                        let newFeeds = Feeds(userName: userName, quote: quote, profileURL: photoURL)
                        //現状のfireStoreのデータを、feedという構造体で構成された配列で保持する。
                        self.feeds.append(newFeeds)
                        //このままだと、古い順にデータが並んでいるので、順番を反転させる。
                        self.feeds.reverse()
                        
                        //非同期処理のための記述
                        DispatchQueue.main.async {
                            
                            self.tableView.tableFooterView = nil
                            self.tableView.reloadData()
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feeds.count
    }
    
    //セルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //カスタムセルを記述したController(FeedCell.swift)の、クラス名と、Identifierをキーにして、何を参照してセルを作成するかを決める。
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedcell", for: indexPath) as! FeedCell
        
        cell.userNameLabel.text = "\(feeds[indexPath.row].userName)さんを表す名言"
        cell.quoteLabel.text = (feeds[indexPath.row].quote)
        cell.profileImageView.sd_setImage(with: URL(string: feeds[indexPath.row].profileURL), completed: nil)
        
        return cell
    }
    
    //セル間の高さを決定する
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.size.height / 10
    }
    
    //セル間の表示のプロパティ？を編集する
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    
    //セルのフッターの高さを調節する。
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
        interactiveTransition.finish()
    }
    
}
