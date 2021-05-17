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
        
        //カスタムセルを二つ作成
        
        

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

}
