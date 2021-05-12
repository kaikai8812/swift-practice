//
//  ViewController.swift
//  Tableview-practice
//
//  Created by ヘパリン類似物質 on 2021/05/12.
//

import UIKit

//TableViewを用いるためには、UITableViewDelegate, UITableViewDataSource、二つのデリゲートが必要
//キーボードも用いるため、UITextFieldDelegateも記載。
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Stringが入る配列を準備
    var textArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
//        navigationController?.isNavigationBarHidden = true
    }
    
    //viewWillappearで、画面が読み込まれるたびに行う処理を記述
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションバーを隠す記述
        navigationController?.isNavigationBarHidden = true
        
        //セルの選択状態を、解除することができる記述
        if let Row = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: Row, animated: true)
        }
        //Rowという定数に、代入することができたら、trueを返すので、それを条件式として使用しているっぽい。
    }
    
    
    
    //UITableViewDataSourcewp使用するためには、以下2つのメソッドが必要
    //TableViewに表示するセルの数を設定する
    // ２ まず、セクションの中のセルの数を確認
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count  //配列.countで、配列の要素の数を返す
    }
    
    //セクションの数を指定する。
    // 1 まず、セクションの数を確認
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //どんな内容を返すかを、設定する。numberOfRowsInSectionの数分実行される。
    //３　どんなセルを返すのかを指定。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //
//        cell.selectionStyle = .none
        cell.textLabel?.text = textArray[indexPath.row]
        cell.imageView!.image = UIImage(named: "checkImage")
        
        return cell
    }
    
    //cellがタップされたときに行う動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //タップした時に、その配列の番号を取り出して、値をわたす。
        
        let nextVC = storyboard?.instantiateViewController(identifier: "next") as! NextViewController
        
        nextVC.toDoString = textArray[indexPath.row] //indexpath.rowで、何番目の要素がタップされたかを取り出すことができる。
        
        navigationController?.pushViewController(nextVC, animated: true)
        
        
    }
    
    //一つのセルあたりの高さを設定する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 6    //viewの高さ全体の1/6を、設定している。
    }
    
    //textFieldのreturnが押されたときに、起動
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textArray.append(textField.text!) //textfieldに入ったテキストを配列に挿入
        textField.resignFirstResponder() //textfieldを閉じる
        textField.text = "" //中身を空にする。
        tableView.reloadData()
        
        return true
        
    }

}

