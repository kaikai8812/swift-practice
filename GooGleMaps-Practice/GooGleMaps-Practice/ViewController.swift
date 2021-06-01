//
//  ViewController.swift
//  GooGleMaps-Practice
//
//  Created by ヘパリン類似物質 on 2021/06/01.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyBW1Tc5IvfPjm_3x-v7CRIQ3z2MLZNqYhM")
        
        //ここで、マップ表示時の位置を決めている
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
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


}

