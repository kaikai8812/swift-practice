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
    
    
    var idString = String()
    
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
        
        //カスタムセルを使用する際の記述
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        loadData()
        
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
                    
                    
                    //いいね追加の際の記述↓
                    if let answer = data["answer"] as? String, let userName = data["userName"] as? String, let likeCount = data["like"] as? Int, let likeFlagDic = data["likeFlagDic"] as? Dictionary<String,Bool>{
                        
                        if likeFlagDic["\(doc.documentID)"] != nil{
                            let answerModel = AnswersModel(answers: answer, userName: userName, docID: doc.documentID, likeCount: likeCount, likeFlagDic: likeFlagDic)
                            
                            self.dataSets.append(answerModel)
                        }
                    }
                    //いいね追加の際の記述↑
                    
                    
                    
                    //もし、各値が存在していたら（doc.documentIDで、ランダムなIDを生成する（後々、この値を用いてどのデータかを識別するため。））
//                    if let answer = data["answer"] as? String, let userName = data["userName"] as? String, let docID = doc.documentID as? String  {
//
//                        print(answer)
//                        print("aoyama")
//                        //answersModel型（構造体）のデータを作成
//                        let answerModel = AnswersModel(answers: answer, userName: userName, docID: docID)
//
//                        //作成したデータを、配列に加える。
//                        self.dataSets.append(answerModel)
//                    }
                }
                self.dataSets.reverse()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        //ラベルの文字の多さによって、大きさが自動で変わるセルを作成する
        tableView.rowHeight = 200 //各セルのデフォルトの高さを指定。
        
        //いいね機能実装の際の記述 ↓
        cell.answerLabel.numberOfLines = 0
        cell.answerLabel.text = "\(self.dataSets[indexPath.row].userName)君の回答\n\(self.dataSets[indexPath.row].answers)"
        //ここで、cellごとにタグ番号を割り振ることで、いいねをする際にどのセルのいいねをするかを判別できるようにする。
        cell.likeButton.tag = indexPath.row
        cell.countLabel.text = String(self.dataSets[indexPath.row].likeCount) + "いいね"
        //プログラム　によるボタンをタップした後のアクションはどこを参照するのかを設定しておく
        cell.likeButton.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
        
        //もし自分のidがlikeFragdicの中のデータに含まれていたら
        if (self.dataSets[indexPath.row].likeFlagDic[idString] != nil) == true {
            
            let flag = dataSets[indexPath.row].likeFlagDic[idString]
            
            //もし、いいねが押されていたら　== 値がtrueだったら、cellのlikeButtonのイメージを、セットする。(bUIButtonのため、setImageを用いる。)
            if flag as! Bool == true{
                cell.likeButton.setImage(UIImage(named: "like"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(named: "nolike"), for: .normal)
            }
            
        }
        //いいね機能実装の際の記述 ↑
        
        
//        //ここで、セル内のどの要素を指定するかを、タグ番号を用いて指定している。
//        let answerLabel = cell.contentView.viewWithTag(1) as! UILabel
//        answerLabel.numberOfLines = 0  //UIlabelなので、このプロパティを指定できる。
//        //Firebaseからとってきたデータを利用して、Labelにはる。
//        answerLabel.text = "\(self.dataSets[indexPath.row].userName)君の回答\n\(self.dataSets[indexPath.row].answers)"
//        print(answerLabel.text)
        
        
        return cell
    }
    
    //いいねボタンを押した際の動き
    @objc func like(_ sender:UIButton) {
        
        var count = Int()
        
        //ここでのsenderは、tableviewでのlikeButtonのことを指す。だから、tagのプロパティを使用することができる。
        //かつ、現在の
        var flag = self.dataSets[sender.tag].likeFlagDic[idString]
        
        //もし、
        if flag == nil {
            count = self.dataSets[sender.tag].likeCount + 1
            db.collection("Answers").document(dataSets[sender.tag].docID).setData(["likeFlagDic " : [idString:true]], merge: true)
            
            
        } else {
            
            if flag as! Bool == true {
                count = self.dataSets[sender.tag].likeCount - 1
                db.collection("Answers").document(dataSets[sender.tag].docID).setData(["likeFlagDic " : [idString:false]], merge: true)
            }else{
                count = self.dataSets[sender.tag].likeCount + 1
                db.collection("Answers").document(dataSets[sender.tag].docID).setData(["likeFlagDic " : [idString:false]], merge: true)
            }
        }
        
        //count情報を送信
        db.collection("Answers").document(dataSets[sender.tag].docID).updateData(["like" : count], completion: nil)
        tableView.reloadData()
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
