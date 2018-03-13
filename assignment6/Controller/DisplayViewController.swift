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
    lazy let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        displayTableView.delegate = self
        displayTableView.dataSource = self
        search.delegate = self

        load()

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
            return customer.count
        } else if section == 1 {
            return room.count
        } else {
            return booking.count
        }
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customDisplayCell", for: indexPath) as! DisplayCell
//
//        if indexPath.section == 0 {
//            cell.customTextView.text = "    \(customer[indexPath.row].name) - " +
//            "\(customer[indexPath.row].id) - " + "\(customer[indexPath.row].phone) - " +
//            "\(customer[indexPath.row].address)"
//        } else if indexPath.section == 1 {
//            cell.customTextView.text = "    \(room[indexPath.row].name) - " +
//            "\(room[indexPath.row].type) - " + "\(room[indexPath.row].price) - " +
//            "\(room[indexPath.row].occupancy)"
//        } else {
//            cell.customTextView.text = "    \(booking[indexPath.row].bookingName) - " +
//            "\(booking[indexPath.row].checkin) - " + "\(booking[indexPath.row].checkout) - " +
//            "\(booking[indexPath.row].customers.name) - " + "\(booking[indexPath.row].customers.id) - " +
//            "\(booking[indexPath.row].customers.phone) - " + "\(booking[indexPath.row].customers.address) - " +
//            "\(booking[indexPath.row].rooms.name) - " + "\(booking[indexPath.row].rooms.type) - " +
//            "\(booking[indexPath.row].rooms.price) - " + "\(booking[indexPath.row].rooms.occupancy)"
//        }
//        return cell
//    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 14)
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.textAlignment = NSTextAlignment.justified
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            if indexPath.section == 0 {
//
//                customer.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            } else if indexPath.section == 1 {
//
//                room.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            } else {
//                booking.remove(at: indexPath.row)
//
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//        }
//    }

    func deleteItem(at indexPath: IndexPath, resutls: Results) {
        if let item = results[indexPath.row] {

            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error deleting item, \(error)")
            }
        }
    }
    
    func load() {
        customer = realm.objects(Customer.self)
        room = realm.objects(Room.self)
        booking = realm.objects(Booking.self)
    }

}

extension DisplayViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        }

    }

