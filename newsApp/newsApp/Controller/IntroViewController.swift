//
//  IntroViewController.swift
//  newsApp
//
//  Created by ヘパリン類似物質 on 2021/05/15.
//

import UIKit
import Lottie

//スクロールビュー用のプロトコル追加
class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardArray = ["1","2","3","4","5"]
    
    var onboardStringArray = ["あいう","かき","さっさ","っさささ","なんで！",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ScrollViewのページング（横にスライドしていくやつ）が使用できるようになる。
        scrollView.isPagingEnabled = true
        
        setUpScroll()
        
        //Lottieを用いたアニメーションの利用記述
        //アニメーションは5種類あるので、for文で回す
        for i in 0...4 {
            
            let animationView = AnimationView()
            //どのアニメーションファイルを使用するかを規定
            let animation = Animation.named(onboardArray[i])
        
            //アニメーションの大きさを決める
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            
            //アニメーションの内容を決める
            animationView.animation = animation
            //アニメーションのプロパティをいくつか設定
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    

    func setUpScroll(){
        
        scrollView.delegate = self
        
        //UIscrollViewのサイズを規定
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: scrollView.frame.size.height)
        
        for i in 0...4{
            
            //使用するUILabelの大きさを規定する
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height / 3, width: view.frame.size.width, height: scrollView.frame.size.height))
            
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[i]
//            onboardLabel.backgroundColor = .blue
            
            //作成したものを画面のLabelに追加
            scrollView.addSubview(onboardLabel)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
