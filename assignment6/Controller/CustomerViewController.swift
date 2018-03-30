//
//  CustomerViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 2/28/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit
import RealmSwift

class CustomerViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    
    let realm = try! Realm()
    var customer: Results<Customer>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        customer = realm.objects(Customer.self)
    }
    
    @IBAction func save(_ sender: Any) {
        
        if !name.hasText || !id.hasText || !phone.hasText || !address.hasText {
            let alert = UIAlertController(title: "Error", message: "Please enter all the required fields!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            name.resignFirstResponder()
            
        } else if Int(phone.text!.count) != 10 || Int(phone.text!) == nil {
            let alert = UIAlertController(title: "Error", message: "Please enter 10 digits phone number!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            phone.resignFirstResponder()
            
        } else {
            let confirm = UIAlertController(title: "Confirmation", message: "You created a new customer!", preferredStyle: .alert)
            confirm.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(confirm, animated: true, completion: nil)
            create()
            
        }
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Create", message: "Do you want to create new customer?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yes", style: .default) { (action) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newView = storyBoard.instantiateViewController(withIdentifier: "customerStoryboard")
            self.navigationController?.pushViewController(newView, animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }

    func create() {
        let newCustomer = Customer()
        newCustomer.name = name.text!
        newCustomer.id = id.text!
        newCustomer.phone = phone.text!
        newCustomer.address = address.text!
        
        do {
            try realm.write {
                realm.add(newCustomer, update: true)
            }
        } catch {
            print("Error creating new customer, \(error)")
        }
    }
}
