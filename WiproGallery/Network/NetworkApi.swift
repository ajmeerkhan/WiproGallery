//
//  GalleryApi.swift
//  WiproGallery
//
//  Created by Ajmeer khan on 01/06/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import UIKit
import Alamofire

class NetworkApi: NSObject {    
    func fetchGallery (url :URL, completionHandler: @escaping (_ responseData:Data?, _ responseError :Error?) -> Void){
        Alamofire.request(url).responseData(queue: .global(qos: .background)) { (responseData) in
            if responseData.result.isSuccess {
                completionHandler(responseData.result.value, nil)
            }else{
                completionHandler(nil, responseData.result.error)
            }
        }
    }
}

