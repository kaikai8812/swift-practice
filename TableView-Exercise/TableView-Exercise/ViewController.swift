//
//  ViewController.swift
//  TableView-Exercise
//
//  Created by ヘパリン類似物質 on 2021/05/13.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var textArray = [String]()
    var imageArray = ["1", "2", "3", "4", "5"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 528
    }
    
    //セルの挙動
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cellを判別するための定型文
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //cell内の要素を判別する記述
        
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let label = cell.contentView.viewWithTag(2) as! UILabel
        
        label.text = textArray[indexPath.row]
        imageView.image = UIImage(named: imageArray[indexPath.row])
        
        return cell
    }
    
    

    @IBAction func tap(_ sender: Any) {
        
        if textArray.count > 5 || textField.text?.isEmpty == true{
            return  //ここでのreturnは、何かを返すという意味ではなく、処理を終わらせるという意味
        }
        //受け取った値を、textArrayに代入する。
        textArray.append(textField.text!)
        textField.text = ""
        
        if textArray.count <= 5{
            tableView.reloadData()
        }
        
    }
    
    
    
}

