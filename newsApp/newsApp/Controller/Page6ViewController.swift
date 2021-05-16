
//
//  Page1ViewController.swift
//  newsApp
//
//  Created by ヘパリン類似物質 on 2021/05/16.
//

import UIKit
import SegementSlide

class Page6ViewController: UITableViewController,SegementSlideContentScrollViewDelegate, XMLParserDelegate {

    //RSSのパース中の現在の要素名
    var currentElementName:String!
    
    //NewsItems型のデータが入る配列を用意
    var newsItems = [NewsItems]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .clear
        
        //画像を、TableViewの背景にする
        
        let image = UIImage(named: "6")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        
        imageView.image = image
        self.tableView.backgroundView = imageView
        
        

    
        
        //XMLパースを作成する
        
        //XMLparserのインスタンスを作成する。
        var parser = XMLParser()
        
        let urlString = "https://news.yahoo.co.jp/rss/topics/top-picks.xml"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        //入れたXMLを解析開始する
        parser.parse()
        
    }
    
    //何なのか謎です
    @objc var scrollView: UIScrollView{
        return tableView
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //親クラスがUITableViewControllerの際に、使用できる。
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        //UIImageViewの背景を透過させるため
        cell.backgroundColor = .clear
        
        let newsItem = self.newsItems[indexPath.row] //selfの必要性を考える
        
        //メインテキストの部分の定義
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        
        //サブタイトルの部分の定義
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white

        return cell
    }
    
    //XMLデータの取得方法
    //parser.parse()で、どのような解析を行うかを記述する。
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        
        if elementName == "item"{
            //条件にあった場合は、newsItemsという配列の中に、中身が空のNewsItems型のデータ箱を用意するイメージ
            self.newsItems.append(NewsItems())
        }else{
            currentElementName = elementName
        }
    }
    
    //上の記述のdidStartElementで、条件にあったものが見つかった場合、今回はelementnameがitemだった場合に次にどのような処理を行うかを記述する。

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.newsItems.count > 0 {
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
            switch self.currentElementName {
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.pubDate = string
            default:
                break
            }
        }
    }
    
    //<title>string</title>の閉じタグ部分に達した時に行う処理
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    //XMLファイルをすべて読み終わった時の起きる処理
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    
    //テーブルのセルをタップした際に呼ばれる処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //WebViewControllerに、linkのurlを渡して、表示をさせる。
        let webViewController = WebViewController()
        webViewController.modalTransitionStyle = .crossDissolve
        let newItem = newsItems[indexPath.row]
        
        //userDefaultsで、タップした要素のurlを保存しておき、webViewControllerで呼び出して、アクセスする。
        UserDefaults.standard.set(newItem.url, forKey: "url")
        //storyboardを作っていなくても、この処理で、他のコントローラを表示させることができる。
        present(webViewController, animated: true, completion: nil)
        
    }
    
    
    
    //

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

