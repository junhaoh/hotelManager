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

class HotelViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    let authURL = "https://api.makcorps.com/auth"
    let hotelURL = "https://api.makcorps.com/free/boston"
    let user = "Junhao"
    let password = "hjh940628"
    var headers: HTTPHeaders = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                print("Got the JWT Token!")
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
                print("hahahahah")
                let hotel = JSON(response.result.value!)["comparison"][0].stringValue
                print(hotel)
                
                self.textView.text = "\(hotel)"
            }
        }
        
    }
    
}






















