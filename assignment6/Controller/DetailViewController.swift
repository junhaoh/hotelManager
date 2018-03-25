//
//  DetailViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/21/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    var booking: Results<Booking>!
    var customer: Results<Customer>!
    var room: Results<Room>!
    
    var row: Int!
    
    var selectedCustomer: Customer? {
        didSet {
            customer = realm.objects(Customer.self)
        }
    }
    
    var selectedRoom: Room? {
        didSet {
            room = realm.objects(Room.self)
        }
    }
    
    var selectedBooking: Booking? {
        didSet {
            booking = realm.objects(Booking.self)
        }
    }
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if selectedCustomer != nil {
            textView.text = "\n\n Name: \(customer[row].name) \n\n" +
            "ID: \(customer[row].id) \n\n" + "Address: \(customer[row].address) \n\n" +
            "Phone: \(customer[row].phone) \n\n"
            
            image.image = UIImage(named: "customer.jpg")
            
        } else if selectedRoom != nil {
            textView.text = "\n\n Name: \(room[row].name) \n\n" +
            "Type: \(room[row].type) \n\n" + "Price: $\(room[row].price) \n\n" +
            "Occupancy: \(room[row].occupancy) \n\n"
            
            if room[row].type == "Single" {
                image.image = UIImage(named: "single.jpg")
            } else {
                image.image = UIImage(named: "double.jpg")
            }
            
        } else {
            
            textView.text = "\n\n BookingName: \(booking[row].bookingName) \n\n" +
            "Check in: \(booking[row].checkin) \n\n" + "Check out: \(booking[row].checkout) \n\n" +
            "\(booking[row].customers.last!) \n\n" + "\(booking[row].rooms.last!) \n\n"
            
        }
        
    }
}
