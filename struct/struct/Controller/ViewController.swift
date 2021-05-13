//
//  ViewController.swift
//  struct
//
//  Created by ヘパリン類似物質 on 2021/05/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,SetOKDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    //Person型の変数と配列を定義
    var person = Person()
    var personArray = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(personArray.count)
        return personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let userNameLabel = cell.contentView.viewWithTag(1) as! UILabel
        userNameLabel.text = personArray[indexPath.row].name
        
        let syumiLabel = cell.contentView.viewWithTag(2) as! UILabel
        syumiLabel.text = personArray[indexPath.row].shumi
        
        let movieLabel = cell.contentView.viewWithTag(3) as! UILabel
        movieLabel.text = personArray[indexPath.row].movie
        
        return cell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
    @IBAction func favButtonAction(_ sender: Any) {
        
        //画面遷移(モーダル)
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    //Person型で受け取ったデータを、checkという箱で受け取っている。このメソッドが発動する条件は、nextVC側で記述がされている。
    func setOK(check: Person) {
        personArray.append(check)
        print(personArray)
        tableView.reloadData()
    }
    
    //モーダルを使用した遷移をした際に呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //nextを使用した遷移の際に呼ばれるメソッド
        if segue.identifier == "next"{
            let nextVC = segue.destination as! NextViewController
            //作成したdelegateを使えるように許可
            nextVC.setOKDelegate = self
        }
    }
    

}

