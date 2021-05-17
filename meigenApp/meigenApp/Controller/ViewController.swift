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
    
    
    @IBAction func toFeedButton(_ sender: Any) {}
        
        
        
    
    
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
    
    
    @IBAction func share(_ sender: Any) {
        
        var postString = String()
        postString = "\(userName)さんを表す名言:\n\(meigenLabel.text!)\n#あなたを表す名変メーカー"
        
        let shareItems = [postString] as [String]
        
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        present(controller, animated: true, completion: nil)
    }
    

}

