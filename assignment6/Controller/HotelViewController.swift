//
//  HotelViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 3/30/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class HotelViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    let authURL = "https://api.makcorps.com/auth"
    let hotelURL = "https://api.makcorps.com/free/boston"
    let user = "Junhao"
    let password = "hjh940628"
    var headers: HTTPHeaders = [:]
    
    let realm = try! Realm()
    var hotel: Results<Hotel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hotel = realm.objects(Hotel.self)
    }
    
    @IBAction func getHotel(_ sender: UIButton) {
        requestInfo(url: authURL)
    }
    
    func requestInfo(url: String) {
        
        let params = [
            "username": user,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got the JWT!")
                print(response)
            } else {
                debugPrint(response)
            }
            
            let token = JSON(response.result.value!)["access_token"].stringValue
            
            let headers: HTTPHeaders = [
                "Authorization": "JWT \(token)"
            ]
            
            Alamofire.request(self.hotelURL, method: .get, headers: headers).responseJSON { (response) in
                if response.result.isSuccess {
                    print("Got the hotel info!")
                    print(response)
                } else {
                    debugPrint(response)
                }
                
                let hotel = JSON(response.result.value!)["comparison"][0]["Hotel"].stringValue
                let rating = JSON(response.result.value!)["comparison"][0]["ratings"].stringValue
                let vendor = JSON(response.result.value!)["comparison"][0]["vendor1"].stringValue
                let vendorArray = vendor.split(separator: "$")
                print(vendorArray)
                let bestPrice = vendorArray[1]
                
                self.name.text = hotel
                self.price.text = "$" + "\(bestPrice)"
                self.rating.text = rating
                
                let newHotel = Hotel()
                newHotel.name = hotel
                newHotel.rating = rating
                newHotel.price = String(bestPrice)
                
                do {
                    try self.realm.write {
                        self.realm.add(newHotel, update: true)
                    }
                } catch {
                    print("Error creating a new hotel! \(error)")
                }
                
                let confirm = UIAlertController(title: "Confirmation", message: "You created a new hotel!", preferredStyle: .alert)
                confirm.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(confirm, animated: true, completion: nil)
            }
        }
        
    }
    
}






















