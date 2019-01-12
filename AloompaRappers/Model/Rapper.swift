//
//  Rapper.swift
//  AloompaRappers
//
//  Created by Hannie Kim on 1/11/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import Foundation
import UIKit

struct Rapper: Decodable {
    let id: String
    let name: String
    let description: String
    let image: String
//

//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case description = "description"
//        case image = "image"
//    }
    
//    init(json: [String: Any]) {
//        id = json["id"] as? String ?? ""
//        name = json["name"] as? String ?? ""
//        description = json["description"] as? String ?? ""
//        image = json["image"] as? String ?? ""
//
//    }
//    init(id: Int, name: String, description: String, image: String) {
//        self.id = id
//        self.name = name
//        self.description = description
//        self.image = image
//    }
//
//    func parseData() {
//
//    }
    
    
}

struct WebDescription: Decodable {
    let artists: [Rapper]
    
}
