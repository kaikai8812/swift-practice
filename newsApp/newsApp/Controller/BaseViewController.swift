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
        defaultSelectedIndex = 0 //どこから表示させるか
        
    }
    //headerを作成するために必要な記述。自動的に呼ばれる
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
        return ["一個目", "2個目", "3個目", "4個目", "5個目", "6個目"]
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
