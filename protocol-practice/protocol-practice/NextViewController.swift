//
//  NextViewController.swift
//  protocol-practice
//
//  Created by ヘパリン類似物質 on 2021/05/13.
//

import UIKit


//①、protocolを作成
protocol CatchProtocol {
    //Int型のデータをcountという変数に入れるメソッドを定義
    func catchData(count:Int)
}

class NextViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    var count = Int()
    
    //プロトコルを変数化して、使えるようにする。
    var delegate:CatchProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func plusAction(_ sender: Any) {
        
        count = count + 1
        label.text = String(count)
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        //デリゲートメソッドを発動させたクラス（今回は、VC）で行われる処理(nextVCでは実際の処理は行われない。)
        delegate?.catchData(count: count)  //delegateに、値を入れる処理を書いていないので、もし入っていなかったら処理をしないように、?をつける。
        dismiss(animated: true, completion: nil)
    }
    
}
