//
//  UIImageView+Extension.swift
//  WiproGallery
//
//  Created by Ajmeer khan on 05/06/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "photos.png")
                    }
                    return
            }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
}
