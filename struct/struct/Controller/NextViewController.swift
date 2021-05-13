//
//  NextViewController.swift
//  struct
//
//  Created by ヘパリン類似物質 on 2021/05/13.
//

import UIKit

//１、プロトコルを作成
protocol SetOKDelegate{
    func setOK(check:Person)
}

class NextViewController: UIViewController {

    //準備した構造体をpersonで、インスタンス化する。
    var person = Person()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var shumiTextField: UITextField!
    @IBOutlet weak var movieTextField: UITextField!
    
    //２、プロトコルを記述できるように変数に代入
    var setOKDelegate:SetOKDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func done(_ sender: Any) {
        
        person.name = nameTextField.text!
        person.shumi = shumiTextField.text!
        person.movie = movieTextField.text!
        
        //３、ここで、ViewControllerのsetOKを呼び出して,personArrayにデータを入れている。->viewcontrollerにデータが渡る（personに入っているデータを、checkとして渡している。）
        setOKDelegate!.setOK(check: person)
        
     
        
        //モーダルを使用した際の、前の画面に戻る記述
        dismiss(animated: true, completion: nil)
        
    }
    

}
