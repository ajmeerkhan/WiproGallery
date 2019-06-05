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
    let rowTitle :String?
    let description: String?
    let imageHref: String?
    
    private enum CodingKeys: String, CodingKey {
        case rowTitle = "title"
        case rowDescription = "description"
        case imageHref
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rowTitle = try values.decodeIfPresent(String.self, forKey: .rowTitle)
        description = try values.decodeIfPresent(String.self, forKey: .rowDescription)
        imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)

    }
}
