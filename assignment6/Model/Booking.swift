//
//  Booking.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/12/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import Foundation
import RealmSwift

class Booking: Object {
    @objc dynamic var bookingName: String = ""
    @objc dynamic var checkin: String = ""
    @objc dynamic var checkout: String = ""
    
    let customers = List<Customer>()
    let rooms = List<Room>()
}
