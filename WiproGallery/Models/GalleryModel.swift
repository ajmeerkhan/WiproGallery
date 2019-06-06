//
//  GalleryModel.swift
//  WiproGallery
//
//  Created by Ajmeer khan on 01/06/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import Foundation
// MARK: - Gallery
struct Gallery: Decodable {
    let title: String
    let rows: [Row]
}

// MARK: - Row
struct Row: Decodable {
    let title :String?
    let description: String?
    let imageHref: String?    
}
