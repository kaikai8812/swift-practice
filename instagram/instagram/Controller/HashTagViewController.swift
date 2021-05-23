//
//  HashTagViewController.swift
//  instagram
//
//  Created by ヘパリン類似物質 on 2021/05/23.
//

import UIKit

class HashTagViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LoadOKDelegate {
    
    //ハッシュタグを受け取る
    var hashTag = String()
    
    //loadモデルをインスタンス化
    var loadDBModel = LoadDBModel()
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var collectonView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectonView.delegate = self
        collectonView.dataSource = self
        loadDBModel.loadOKDelegate = self
        
        self.navigationItem.title = "#\(hashTag)"
        
        //ハッシュタグを渡し、表示するデータの元となる配列(dataSets)を作成
        loadDBModel.loadHashTag(hashTag: hashTag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topImageView.layer.cornerRadius = 40.0
    }
    
    
    func loadOK(check: Int) {
        if check == 1{
            collectonView.reloadData()
        }
    }
    
    //コレクションビューに関する記述
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        countLabel.text = String(loadDBModel.dataSets.count)
        
        return loadDBModel.dataSets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let contentImageView = cell.contentView.viewWithTag(1) as! UIImageView
        
        contentImageView.sd_setImage(with: URL(string: loadDBModel.dataSets[indexPath.row].contentImage), completed: nil)
        
        //topviewには、最新の投稿を表示する。
        topImageView.sd_setImage(with: URL(string: loadDBModel.dataSets[0].contentImage), completed: nil)
        
        return cell
    }
    
    //cellをタップした際の動き
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = self.storyboard?.instantiateViewController(identifier: "detailVC") as! DetailViewController

        detailVC.userName = loadDBModel.dataSets[indexPath.row].userName
        detailVC.comment = loadDBModel.dataSets[indexPath.row].comment
        detailVC.contentImageString = loadDBModel.dataSets[indexPath.row].contentImage
        detailVC.profileImage = loadDBModel.dataSets[indexPath.row].profileImage

        self.navigationController?.pushViewController(detailVC, animated: true)

    }
    
    //レイアウト関係の記述
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width/3.0
            let height = width
            return CGSize(width: width, height: height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.zero
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    

}
