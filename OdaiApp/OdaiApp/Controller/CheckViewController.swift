//
//  CheckViewController.swift
//  OdaiApp
//
//  Created by ヘパリン類似物質 on 2021/05/19.
//

import UIKit
import Firebase
import FirebaseFirestore

class CheckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var odaiString = String()
    
    var dataSets = [AnswersModel]()
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var odaiLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        odaiLabel.text = odaiString
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    //fireStoreから、answerデータを取ってくる関数
    func loadData() {
        
        //DB上のAnswersを、取ってくる
        db.collection("Answers").addSnapshotListener { snapShot, error in
            
            self.dataSets = []
            
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            //snapShotDocに入っているものは、まだドキュメントの集合体
            if let snapShotDoc = snapShot?.documents {
                
                //ここで、集合体を一つずつ確認していく
                for doc in snapShotDoc {
                    //ドキュメントのデータにアクセスできる形にして、dataに代入
                    let data = doc.data()
                    
                    //もし、各値が存在していたら（doc.documentIDで、ランダムなIDを生成する（後々、この値を用いてどのデータかを識別するため。））
                    if let answer = data["answer"] as? String, let userName = data["userName"] as? String, let docID = doc.documentID as? String  {
                        
                        //answersModel型（構造体）のデータを作成
                        let answerModel = AnswersModel(answers: answer, userName: userName, docID: docID)
                        
                        //作成したデータを、配列に加える。
                        self.dataSets.append(answerModel)
                    }
                }
                //for文でデータを配列に入れ終わったら、tableViewをリロードして、反映させる。
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSets.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.estimatedRowHeight = 100
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //使用するセルを特定
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //ラベルの文字の多さによって、大きさが自動で変わるセルを作成する
        tableView.rowHeight = 200 //各セルのデフォルトの高さを指定。
        //ここで、セル内のどの要素を指定するかを、タグ番号を用いて指定している。
        let answerLabel = cell.contentView.viewWithTag(1) as! UILabel
        answerLabel.numberOfLines = 0  //UIlabelなので、このプロパティを指定できる。
        //Firebaseからとってきたデータを利用して、Labelにはる。
        answerLabel.text = "\(self.dataSets[indexPath.row].userName)君の回答\n\(self.dataSets[indexPath.row].answers)"
//        print(answerLabel.text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //画面遷移
        let commentVC = self.storyboard?.instantiateViewController(identifier: "commentVC") as! CommentViewController
        commentVC.idString = dataSets[indexPath.row].docID
        commentVC.kaitouString = "\(dataSets[indexPath.row].userName)君の回答\n\(dataSets[indexPath.row].answers)"
        
        self.navigationController?.pushViewController(commentVC, animated: true)
        
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
