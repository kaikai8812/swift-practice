//
//  ViewController.swift
//  mapAndProtocol
//
//  Created by ヘパリン類似物質 on 2021/05/13.
//

import UIKit
//マップを使用する時は、以下二つをimportする。どちらもデリゲートメソッドを持つ。
import MapKit   //mapの表示関連のkit
import CoreLocation    //mapの座標関連を取得できたりするやつ

class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate {

    
    
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var locManager:CLLocationManager!  //??
    var addressString = String()  //住所を入れる箱
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingButton.backgroundColor = .white
        settingButton.layer.cornerRadius = 20.0 //角丸にするための処理
        
    }

    //senderの中には、何かしらの情報が入ってくる。今回は、ロングタップという処理が入っている。
    @IBAction func LongPressTap(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began{
            //ロングタップが始まった時の処理
        }else if sender.state == .ended {
            //ロングタップが終了した時の処理
            //タップした位置を取得して、mapview上の緯度、経度を取得
            //緯度、経度から住所を取得する。
            
            //タップしたポイントを取得
            let tapPoint = sender.location(in: view)
            
            //tapPointを用いて、mapView上の緯度経度を取得する。 convertは、MKMapViewが持つ緯度軽度を取得するメソッド
            let center = mapView.convert(tapPoint, toCoordinateFrom:mapView)
            
            let lat = center.latitude
            let log = center.longitude
            
            convert(lat: lat, log: log)
        }
    }
    
    //緯度、経度を受け取って、住所に変換するメソッド
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees) {
        let geocorder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        //クロージャーと呼ばれる
        //このメソッドにlocationで、緯度経度の情報を渡している！
        geocorder.reverseGeocodeLocation(location) {(placeMark,error) in
            
            //この書き方で、placeMaekがnikじゃなかったら、という条件式。
            if let placeMark = placeMark {
                //placeMarkは、配列？？
                if let pm = placeMark.first{
                    //都市名か村名？が存在した場合は、以下の処理が呼ばれる。
                    if pm.administrativeArea != nil || pm.locality != nil {
                        
                        self.addressString = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{ //都市名等がなかった場合は、そこにある代表的なnameが呼ばれる。 pm.name は、代表的な建物などが入っている。
                        self.addressString = pm.name!
                    }
                    //クロージャー外で定義した変数を使用する場合は、selfを使用しなければならない。
                    self.addressLabel.text = self.addressString
                    
                }
            }
        }
    }
    
    
    @IBAction func goToSearchVC(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next" {
            let nextVC = segue.destination as! NextViewController
        }
    }
    
    
    
}

//クロージャーの説明に関して、言い間違いがありました。
//正確には、値が入ったあとに括弧内が呼ばれ、値が入るまでは括弧の外が呼ばれるということになります！
