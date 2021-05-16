//
//  BaseViewController.swift
//  newsApp
//
//  Created by ヘパリン類似物質 on 2021/05/16.
//

import UIKit
import SegementSlide //タブがついた繊維ができるようになる。

//SegementSlideを使用する場合は、親コントローラーを下記のように変更する必要があり。
class BaseViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData() //お決まり文句
        defaultSelectedIndex = 2 //最初に選択しているタブを設定
        
    }
//    headerを作成するために必要な記述。自動的に呼ばれる
    override func segementSlideHeaderView() -> UIView {
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true //変更して何が変わるか確認
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false

        let headerHeight:CGFloat

        if #available(iOS 11.0, *) {

            headerHeight = view.bounds.height/4+view.safeAreaInsets.top

        } else {

            headerHeight = view.bounds.height/4+topLayoutGuide.length

        }

        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true //これも、後で値を変更して確認

        return headerView
    }

    //タブを生成するもの
    override var titlesInSwitcher: [String]{
        return ["Top", "Abemanews", "Yahoo!", "IT", "Buzz", "CNN"]
    }
    
    //下記の記述で、タブに対応したページを返す処理を書く。作成したpage1ViewControllerなどは、ここで返すために作成されていた。
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
        case 0:
            return Page1ViewController()
        case 1:
            return Page2ViewController()
        case 2:
            return Page3ViewController()
        case 3:
            return Page4ViewController()
        case 4:
            return Page5ViewController()
        case 5:
            return Page6ViewController()
        default:
            return Page1ViewController()
        }
    }
    
//    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
