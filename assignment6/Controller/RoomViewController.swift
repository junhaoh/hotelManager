//
//  RoomViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 2/28/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit
import RealmSwift

class RoomViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var occupancy: UISegmentedControl!
    
    var strType: String = ""
    var strOccupancy: String = ""
    
    let realm = try! Realm()
    var room: Results<Room>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func typeChanged(_ sender: Any) {
        if type.selectedSegmentIndex == 0 {
            strType = "Single"
        } else if type.selectedSegmentIndex == 1 {
            strType = "Double"
        }
    }
    
    @IBAction func occupancyChanged(_ sender: Any) {
        if occupancy.selectedSegmentIndex == 0 {
            strOccupancy = "Vacant"
        } else if occupancy.selectedSegmentIndex == 1 {
            strOccupancy = "Occupied"
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        if !name.hasText || !price.hasText {
            let alert = UIAlertController(title: "Error", message: "Please enter all the required fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            name.resignFirstResponder()
            
        } else {
            let confirm = UIAlertController(title: "Confirmation", message: "You created a new room!", preferredStyle: .alert)
            confirm.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(confirm, animated: true, completion: nil)
            
            create()
            
        }
    }
    
    func create() {
        let newRoom = Room()
        newRoom.name = name.text!
        newRoom.type = strType
        newRoom.price = price.text!
        newRoom.occupancy = strOccupancy
        
        do {
            try realm.write {
                realm.add(newRoom)
            }
        } catch {
            print("Error creating new room, \(error)")
        }
    }
    
    
    
}
