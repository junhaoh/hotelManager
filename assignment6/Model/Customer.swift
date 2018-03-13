//
//  Customer.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/12/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import Foundation
import RealmSwift

class Customer: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var address: String = ""
    
    var parent = LinkingObjects(fromType: Booking.self, property: "customers")
}
