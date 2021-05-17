//
//  ViewController.swift
//  meigenApp
//
//  Created by ヘパリン類似物質 on 2021/05/16.
//

import UIKit
import BubbleTransition //丸が広がるようなアニメーションを作成
import Firebase

class FeedItem{
    var meigen:String!
    var author:String!
}

class ViewController: UIViewController , XMLParserDelegate, UIViewControllerTransitioningDelegate{
    
    var userName = String()
    
    let db = Firestore.firestore()
    let transition = BubbleTransition()
    let interactiveTransition = BubbleInteractiveTransition()
    var parser = XMLParser()
    
    //XML解析関係
    var feeditems = [FeedItem()]
    var currentElementName:String!
    
    @IBOutlet weak var meigenLabel: UILabel!
    @IBOutlet weak var toFeedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
  
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toFeedButton.layer.cornerRadius = toFeedButton.frame.width/2 //ボタンを丸にする
        
        self.navigationController?.isNavigationBarHidden = true
        
        //XML解析の記述
        let url:String = "http://meigen.doodlenote.net/api?c=1" //httpサイトにアクセスする際は、plistをいじる必要あり。
        let urlToSend = URL(string:url)
        parser = XMLParser(contentsOf: urlToSend!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        
        if elementName == "data" {
            feeditems.append(FeedItem())
        }else {
            currentElementName = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if feeditems.count > 0 {
            let lastItem = feeditems[feeditems.count - 1]
            
            switch currentElementName {
            case "meigen":
                lastItem.meigen = string
            case "author":
                lastItem.author = string
                
                meigenLabel.text = lastItem.meigen + "\n" + lastItem.author
            default:
                break
            }
        }
    }
      
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElementName = nil
    }
    
    
    
    
    //シェアボタン、機能の作成
    @IBAction func share(_ sender: Any) {
        
        var postString = String()
        postString = "\(userName)さんを表す名言:\n\(meigenLabel.text!)\n#あなたを表す名変メーカー"
        
        let shareItems = [postString] as [String]  //シェアする際の渡すデータは、配列で作成する。
        
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        present(controller, animated: true, completion: nil)
    }
    
    //firestoreに、データを保存する。
    @IBAction func sendData(_ sender: Any) {
        
        if let quote = meigenLabel.text, let userName = Auth.auth().currentUser?.uid{
            
            //保存するデータ内容を記述する。データは、辞書型で記入する。
            //Auth.auth.currnetUserで、現在ログインしているユーザーの情報を取得でできる。
            //Date().timeIntervalSince1970で、日時を取得できる。
            db.collection("feed").addDocument(data: ["userName": Auth.auth().currentUser?.displayName, "quote": meigenLabel.text, "photoURL": Auth.auth().currentUser?.photoURL?.absoluteString, "createAt":Date().timeIntervalSince1970]) { error in
                if error != nil{
                    print(error.debugDescription)
                    return
                }
            }
        }
    }
    
    
    @IBAction func tofeedVC(_ sender: Any) {
        
        performSegue(withIdentifier: "feedVC", sender: nil)
        
    }
    
    //ログアウト処理
    @IBAction func logout(_ sender: Any) {
        
        //ナビゲーションバーを使用した時の、前画面に戻る処理
        self.navigationController?.popViewController(animated: true)
        
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let controller = segue.destination as? FeedViewController {
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = .custom
            controller.modalPresentationCapturesStatusBarAppearance = true
            controller.interactiveTransition = interactiveTransition 
            interactiveTransition.attach(to: controller)
          }
        }

        
        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
          transition.transitionMode = .present
          transition.startingPoint = toFeedButton.center
          transition.bubbleColor = toFeedButton.backgroundColor!
          return transition
        }
        
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
          transition.transitionMode = .dismiss
          transition.startingPoint = toFeedButton.center
          transition.bubbleColor = toFeedButton.backgroundColor!
          return transition
        }
        
        func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
          return interactiveTransition
        }
}

