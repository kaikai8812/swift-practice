//
//  NextViewController.swift
//  mapAndProtocol
//
//  Created by ヘパリン類似物質 on 2021/05/13.
//

import UIKit

//プロトコルを作成
protocol SearchLocationDeledate {
    func searchLocation(idovalue:String, keidoValue:String)
}

class NextViewController: UIViewController {

    
    @IBOutlet weak var idoTextField: UITextField!
    @IBOutlet weak var keidoTextField: UITextField!
    
    //プロトコルを変数化
    var delegate:SearchLocationDeledate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func okAction(_ sender: Any) {
        
        //入力された値を取得
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
        
        //テキストフィールドが空でなければ、画面を戻る。
        if idoTextField.text != nil && keidoTextField.text != nil{
            
        //デリゲートメソッドの引数に入れる これで、他のコントローラーで使用できる準備が完了
        delegate?.searchLocation(idovalue: idoValue, keidoValue: keidoValue)
        
        
        
            dismiss(animated: true, completion: nil)
        }
        
    }
    
 

}
