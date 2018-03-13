//
//  Room.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/12/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import Foundation
import RealmSwift

class Room: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var occupancy: String = ""
    
    var parent = LinkingObjects(fromType: Booking.self, property: "rooms")
    
}
