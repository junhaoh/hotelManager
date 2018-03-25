//
//  DisplayViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 2/28/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sectionTitle = ["Customer: Name -> ID -> Phone -> Address",
                        "Room: Name -> Type -> Price -> Occupancy",
                        "Booking: Name -> Check in -> Check out -> Info"]

    @IBOutlet weak var displayTableView: UITableView!
    @IBOutlet weak var search: UISearchBar!

    var booking: Results<Booking>!
    var customer: Results<Customer>!
    var room: Results<Room>!
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        displayTableView.delegate = self
        displayTableView.dataSource = self
        search.delegate = self

        loadObjects()

        displayTableView.register(UINib(nibName: "DisplayCell", bundle: nil), forCellReuseIdentifier: "customDisplayCell")

        displayTableView.estimatedRowHeight = 55
        displayTableView.rowHeight = UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return customer?.count ?? 1
        } else if section == 1 {
            return room?.count ?? 1
        } else {
            return booking?.count ?? 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customDisplayCell", for: indexPath) as! DisplayCell
        
        let row = indexPath.row

        if indexPath.section == 0 {
            cell.customTextView.text = "    \(customer[row].name) - " +
            "\(customer[row].id) - " + "\(customer[row].phone) - " +
            "\(customer[row].address)"
        } else if indexPath.section == 1 {
            cell.customTextView.text = "    \(room[row].name) - " +
            "\(room[row].type) - " + "\(room[row].price) - " +
            "\(room[row].occupancy)"
        } else {
            cell.customTextView.text = "    \(booking[row].bookingName) - " +
            "\(booking[row].checkin) - " + "\(booking[row].checkout) \n" +
                "   \(booking[row].customers.last!) - " + "    \(booking[row].rooms.last!)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 14)
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.textAlignment = NSTextAlignment.justified
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                try! realm.write {
                    realm.delete(customer[indexPath.row])
                }
                
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } else if indexPath.section == 1 {
                try! realm.write {
                    realm.delete(room[indexPath.row])
                }
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                try! realm.write {
                    realm.delete(booking[indexPath.row])
                }

                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        if let indexPath = displayTableView.indexPathForSelectedRow {
            let row = indexPath.row
            
            if indexPath.section == 0 {
                destinationVC.selectedCustomer = customer[row]
                destinationVC.row = row
            } else if indexPath.section == 1 {
                destinationVC.selectedRoom = room[row]
                destinationVC.row = row
            } else {
                destinationVC.selectedBooking = booking[row]
                destinationVC.row = row
            }
        }
    }
        
    
    func loadObjects() {
        customer = realm.objects(Customer.self)
        room = realm.objects(Room.self)
        booking = realm.objects(Booking.self)
        
        displayTableView.reloadData()
    }
}

extension DisplayViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        customer = customer.filter("name CONTAINS[cd] %@", search.text!)
        room = room.filter("name CONTAINS[cd] %@", search.text!)
        booking = booking.filter("bookingName CONTAINS[cd] %@", search.text!)

        displayTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if search.text?.count == 0 {
            loadObjects()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }

    }
}

