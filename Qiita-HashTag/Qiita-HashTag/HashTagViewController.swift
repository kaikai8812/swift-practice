//
//  HashTagViewController.swift
//  Qiita-HashTag
//
//  Created by ヘパリン類似物質 on 2021/06/04.
//

import UIKit
import ActiveLabel
import FirebaseFirestore

class HashTagViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {

    //TableViewControllerから、タップしたハッシュタグの情報を取得するため
    var hashTag = String()
    var textArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プロトコルの委任
        tableView.delegate = self
        tableView.dataSource = self
        
        //取得したハッシュタグのデータをもとに、fireStoreからデータを取得し画面に反映させる。
        loadData(hashTag: hashTag)
    }
    
    //tableのセルの数は、取得するデータ数に設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        textArray.count
    }
    
    //取得してきたデータを、セル内のラベル（textLabelに反映
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //storyBoard上のセルと、紐付けを行なっています。
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let textLabel = cell.contentView.viewWithTag(1) as! ActiveLabel   // ActiveLabelに変更する
        
        //取得してきた文字列をセルに反映しています。
        textLabel.text = textArray[indexPath.row]
        
        //ハッシュタグをタップしたら、そのハッシュタグに適したデータを再ロードする
        textLabel.handleHashtagTap { hashTag in
            self.loadData(hashTag: hashTag)
        }
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
    func loadData(hashTag:String){
        
        //collectionの引数をhashTagにすることによって、選択したハッシュタグに関連するデータだけを抽出する。
        Firestore.firestore().collection("#\(hashTag)").addSnapshotListener { snapShot, error in
            
            self.textArray = []
            
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
                self.navigationItem.title = "#\(hashTag)"
            }
        }
    }
}
