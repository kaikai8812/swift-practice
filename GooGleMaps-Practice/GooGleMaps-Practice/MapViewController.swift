//
//  MapViewController.swift
//  GooGleMaps-Practice
//
//  Created by ヘパリン類似物質 on 2021/06/02.
//

import UIKit
import MapKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var address = String()
    var latitude = Double()
    var longitude = Double()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //住所を座標に変換
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            
            //緯度を変数に保存
            if let lat = placemarks?.first?.location?.coordinate.latitude {
                self.latitude = lat
                print("緯度 : \(lat)")
            }
            
            //経度を変数に保存
            if let lng = placemarks?.first?.location?.coordinate.longitude {
                self.longitude = lng
                print("経度 : \(lng)")
                print("")
            }
        }
        
        
        print(latitude)
        print(longitude)
        print("")
        //ここから、googleMapsの記述
        
        GMSServices.provideAPIKey("AIzaSyBW1Tc5IvfPjm_3x-v7CRIQ3z2MLZNqYhM")
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        marker.title = address
        marker.map = mapView

        
    }
    
    
    //住所を井戸、経度に変換する関数
    func geocode(address:String) {
        
        CLGeocoder().geocodeAddressString(address) { placemarks, error in
            
            //緯度を変数に保存
            if let lat = placemarks?.first?.location?.coordinate.latitude {
                self.latitude = lat
                print("緯度 : \(lat)")
            }
            
            //経度を変数に保存
            if let lng = placemarks?.first?.location?.coordinate.longitude {
                self.longitude = lng
                print("経度 : \(lng)")
                print("")
            }
            
        }
        
    }
    

}

//緯度 : 35.1226382
//経度 : 136.9750189
