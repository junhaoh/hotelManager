//
//  Hotel.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/31/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import Foundation
import RealmSwift

class Hotel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var rating: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}

