//
//  ViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 2/28/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addCustomer(_ sender: UIButton) {
        performSegue(withIdentifier: "goToCustomer", sender: self)
    }
    
    @IBAction func addRoom(_ sender: Any) {
         performSegue(withIdentifier: "goToRoom", sender: self)
    }
    
    @IBAction func addBooking(_ sender: Any) {
        performSegue(withIdentifier: "goToBooking", sender: self)
    }
    
    @IBAction func addDisplay(_ sender: Any) {
        performSegue(withIdentifier: "goToDisplay", sender: self)
    }
    
    @IBAction func addHotel(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHotel", sender: self)
    }
    
}

