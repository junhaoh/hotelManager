//
//  RoomViewController.swift
//  assignment6
//
//  Created by JUNHAO HUANG on 2/28/18.
//  Copyright © 2018 Junhao Huang. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class RoomViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var occupancy: UISegmentedControl!
    
    @IBOutlet weak var image: UIImageView!
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    var strType: String = ""
    var strOccupancy: String = ""
    
    let realm = try! Realm()
    var room: Results<Room>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        room = realm.objects(Room.self)
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
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Create", message: "Do you want to create new room?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yes", style: .default) { (action) in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newView = storyBoard.instantiateViewController(withIdentifier: "roomStoryboard")
            self.navigationController?.pushViewController(newView, animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        let uploadImage = UIImagePickerController()
        uploadImage.delegate = self
        uploadImage.allowsEditing = false
        uploadImage.sourceType = .photoLibrary
        self.present(uploadImage, animated: true, completion: nil)
    }
    
    func create() {
        let newRoom = Room()
        newRoom.name = name.text!
        newRoom.type = strType
        newRoom.price = price.text!
        newRoom.occupancy = strOccupancy
        
        do {
            try realm.write {
                realm.add(newRoom, update: true)
            }
        } catch {
            print("Error creating new room, \(error)")
        }
    }
    
}

extension RoomViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = imageData
        } else {
            print("No image upload!")
        }
        
        guard let imageJPEG = UIImageJPEGRepresentation(image.image!, 1) else { return }
        
        let uploadImageRef = imageReference.child("image.image!")
        
        let uploadTask = uploadImageRef.putData(imageJPEG, metadata: nil) { (metadata, error) in
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}











