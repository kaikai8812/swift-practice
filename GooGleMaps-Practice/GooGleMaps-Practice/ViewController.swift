//
//  ViewController.swift
//  GooGleMaps-Practice
//
//  Created by ヘパリン類似物質 on 2021/06/01.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        //アプリの使用中に、ユーザーに位置情報サービスの使用許可を求める記述
        manager.requestWhenInUseAuthorization()
        //ユーザーの現在地を報告する更新の生成  ここで、デバイスの現在位置をmanagerに設定している？
        manager.startUpdatingLocation()
        
        GMSServices.provideAPIKey("AIzaSyBW1Tc5IvfPjm_3x-v7CRIQ3z2MLZNqYhM")
        
        //ここで、マップ表示時の位置を決めている
        let camera = GMSCameraPosition.camera(withLatitude: 35.689506, longitude: 139.6917, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
        //ここで、マップにつけるマーカーの位置を決めている。
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        //マーカーのタイトル等を、決めている
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationsに、位置情報が入る。locationに何も入らなかったら、処理をreturnする。
        guard let location  = locations.first else {
            return
        }
        //coordinate ==　座標
        let coordinate = location.coordinate
        
        //取得した座標から、
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        //マーカーのタイトル等を、決めている
        marker.title = "現在地です"
        marker.snippet = "現在地だよ"
        marker.map = mapView
    }
    
    
}


//やりたいこと => お店の位置を登録　=> 位置情報をタップしたら、そこのお店にマーカーがついて、名前とかが表示されるようにする。
//そのためには、住所と座標を変換するプログラムが必要
//fireStoreには、住所で保存
