//
//  TableViewController.swift
//  Qiita-HashTag
//
//  Created by ヘパリン類似物質 on 2021/06/04.
//

import UIKit
import FirebaseFirestore

class TableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //取得したデータが入る配列
    var textArray = [String]()
    
    //StoryBoard上のtableViewと紐づけています。
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プロトコルの委任
        tableView.delegate = self
        tableView.dataSource = self
        
        //データの取得、およびtableViewを読み込むメソッドを使用
        loadData()
        
    }
    
    //tableのセルの数は、取得するデータ数に設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        textArray.count
    }
    
    //取得してきたデータを、セル内のラベル（textLabelに反映
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //storyBoard上のセルと、紐付けを行なっています。
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let textLabel = cell.contentView.viewWithTag(1) as! UILabel
        
        //取得してきた文字列をセルに反映しています。
        textLabel.text = textArray[indexPath.row]
        
        return cell
    }
    
    //セルの高さは、適当に設定しています。
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 10
    }
    
    //セクションの数は1です
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    //fireStoreから、データを取得する関数
    func loadData(){
        
        Firestore.firestore().collection("collection").addSnapshotListener { snapShot, error in
            
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    
                    if let text = data["text"] as? String {
                        print(text)
                        //取得してきたデータを、配列に入れていく。
                        self.textArray.append(text)
                    }
                }
                //データを取得し終わったら、tableViewを更新する。
                self.tableView.reloadData()
            }
        }
    }
}
