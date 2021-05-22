
//カメラおよびアルバムの使用許可を取るためのモデル。

import Foundation
import Photos

class CheckModel{
    
    func showCheckPermission(){
        
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
