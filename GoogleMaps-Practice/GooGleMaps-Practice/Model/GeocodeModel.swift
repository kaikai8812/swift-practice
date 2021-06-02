//
//  Geocodemodel.swift
//  GooGleMaps-Practice
//
//  Created by ヘパリン類似物質 on 2021/06/02.
//

import Foundation
import MapKit
import GoogleMaps

protocol GetCoordinate {
    
    func getCoordinateData(latitude:Double,longitude:Double)
    
}

class GeocodeModel  {
    
    var latitude = Double()
    var longitude = Double()
    
    var getCoordinate:GetCoordinate?
    
    func geocode(address: String)  {
        
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
            
            self.getCoordinate?.getCoordinateData(latitude: self.latitude, longitude: self.longitude)
        }
        
    }
}

