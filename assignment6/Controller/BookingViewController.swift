//
//  BookingViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 2/28/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit
import RealmSwift

class BookingViewController: UIViewController {
    
    @IBOutlet weak var bookingName: UITextField!
    @IBOutlet weak var customerName: UITextField!
    @IBOutlet weak var roomName: UITextField!

    @IBOutlet weak var selectedCheckin: UILabel!
    @IBOutlet weak var selectedCheckout: UILabel!
    
    @IBOutlet weak var checkin: UIDatePicker!
    @IBOutlet weak var checkout: UIDatePicker!
    
    var booking: Results<Booking>!
    var customer: Results<Customer>!
    var room: Results<Room>!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkin.minimumDate = Date()
        checkout.minimumDate = Date()
        
        load()
    }

    @IBAction func checkinChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        selectedCheckin.text = dateFormatter.string(from: checkin.date)
    }
    
    @IBAction func checkoutChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        selectedCheckout.text = dateFormatter.string(from: checkout.date)
    }
    
    @IBAction func save(_ sender: Any) {

        for i in 0..<customer.count {
            for j in 0..<room.count {
                if room[j].name == roomName.text! && customer[i].name == customerName.text! {
                    
                    if checkout.date > checkin.date && room[j].occupancy == "Vacant" {
                        let confirm = UIAlertController(title: "Confirmation", message: "You created a new booking!", preferredStyle: .alert)
                            confirm.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(confirm, animated: true, completion: nil)
                        
                        try! realm.write {
                            room[j].occupancy = "Occupied"
                        }
                        
                        let newBooking = Booking()
                        newBooking.bookingName = bookingName.text!
                        newBooking.checkin = selectedCheckin.text!
                        newBooking.checkout = selectedCheckout.text!
                        newBooking.customers.append(customer[i])
                        newBooking.rooms.append(room[j])
                        
                        create(booking: newBooking)
                        
                    } else if checkout.date <= checkin.date {
                        let alert = UIAlertController(title: "Error",
                                                      message: "Check out date must be greater than check in date",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Error",
                                                      message: "Either room or customer is unavailable, please create them first!",
                                                      preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        customerName.resignFirstResponder()
                    }
                }
            }
        }
    }
   
    
    func create(booking: Booking) {
        do {
            try realm.write {
                realm.add(booking)
            }
        } catch {
            print("Error creating new booking, \(error)")
        }
    }
    
    func load() {
        customer = realm.objects(Customer.self)
        room = realm.objects(Room.self)
        booking = realm.objects(Booking.self)
    }
    
    

}
