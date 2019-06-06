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

    func fetchGallery(completion: @escaping (Gallery?, String, Bool) -> Void) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            completion(nil, "Invalid url!", false)
            return
        }
        
        callApi(url: url) { (responseData, responseError) in
            if responseError == nil {
                guard let data = responseData else{
                    print("Error : No Data Found")
                    completion(nil, "No Data Found!", false)
                    return
                }
                
                guard let str = String(bytes: data, encoding: .ascii) else {
                    completion(nil, "Encoding Error!", false)
                    return
                }
                let utfData = Data(str.utf8)
                do {
                    let gallery = try JSONDecoder().decode(Gallery.self, from: utfData)
                    print("Real Data found")
                    completion(gallery, "", true)
                }catch{
                    print("Parse Error :\(error.localizedDescription)")
                    completion(nil, error.localizedDescription, false)
                }
            }
        }
    }
    
    func callApi (url :URL, completionHandler: @escaping (_ responseData:Data?, _ responseError :Error?) -> Void){
        Alamofire.request(url).responseData(queue: .global(qos: .background)) { (responseData) in
            if responseData.result.isSuccess {
                completionHandler(responseData.result.value, nil)
            }else{
                completionHandler(nil, responseData.result.error)
            }
        }
    }
}

