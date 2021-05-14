//
//  CheckPermisson.swift
//  CameraApp
//
//  Created by ヘパリン類似物質 on 2021/05/14.
//

import Foundation
import Photos


class CheckPermisson{
    //ユーザーに許可を促す処理
    func checkCamera(){
        
        PHPhotoLibrary.requestAuthorization{ (status) in
            switch(status){
            
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorized:
                print("authorized")
            case .limited:
                print("limited")
            @unknown default:
                break
            }
        }
        
    }
}



