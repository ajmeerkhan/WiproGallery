//
//  GalleryApi.swift
//  WiproGallery
//
//  Created by Ajmeer khan on 01/06/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import UIKit
import Alamofire

class GalleryApi: NSObject {

    func fetchGallery(completion: @escaping (Gallery?, String, Bool) -> Void) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            completion(nil, "Invalid url!", false)
            return
        }

        Alamofire.request(url).responseData(queue: .global(qos: .background)) { (responseData) in
            if responseData.result.isSuccess {
                guard let data = responseData.result.value else{
                    print("Error : No Data Found")
                    completion(nil, "No Data Found!", false)
                    return
                }
                
                guard let str = String(bytes: data, encoding: .ascii) else {
                    completion(nil, "Encoding Error!", false)
                    return
                }
                let utfData = Data(str.utf8)
                print("Real String \(str)")
                do {
                    let gallery = try JSONDecoder().decode(Gallery.self, from: utfData)
                    print("Real Data found")
                    completion(gallery, "", true)
                }catch{
                    print("Parse Error :\(error.localizedDescription)")
                    completion(nil, error.localizedDescription, false)
                }
            }else{
                completion(nil, responseData.result.error?.localizedDescription ?? "Loading Failed!", false)
            }
        }
    }
}
