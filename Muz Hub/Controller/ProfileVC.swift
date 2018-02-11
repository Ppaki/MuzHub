//
//  ProfileVC.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/12/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import CoreLocation
import MapKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: CenterVCDelegate?
    
    var user: User!
    var institutions = [Institution]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var otherInfoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if Auth.auth().currentUser != nil && user == nil {
            self.user = FirebaseService.MS.user
            self.tableView.reloadData()
            nameLabel.text = user.name
            emailLabel.text = user.email
            otherInfoLabel.text = user.provider
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        //dont need this anymore
        //institutions.removeAll()
        //user = nil
        
    }

    @IBAction func menuButtonWasPressed(_ sender: UIButton) {
        delegate?.toggleLeftPanel()
    }
    
    // MARK: - TableView Stuff
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "institute", for: indexPath)
        
        loadFavorites(complete: {
            cell.textLabel?.text = self.institutions[indexPath.row].name
        }, row: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Auth.auth().currentUser != nil {
            return self.user.favInstitutions.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "institution", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "institution" {
            let destinationController: ViewController = (segue.destination as? ViewController)!
            let indexRow = self.tableView.indexPathForSelectedRow?.row
            destinationController.institute = self.institutions[indexRow!]
        }
    }
    
    // MARK: Helper Helper
    
    func loadFavorites(complete: @escaping DownloadCompleted, row: Int) {
        var institute: Institution!
        let ref = Database.database().reference()
        let key = user.favInstitutions[row]
        
        ref.child("institution").child(key).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let info = value?["info"] as? String ?? ""
            
            institute = Institution(id: key, name: name, info: info)
            self.institutions.append(institute)
        }
        
        ref.child("location").child(key).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let latitude = value!["latitude"] as? CLLocationDegrees
            let longitude = value!["longitude"] as? CLLocationDegrees
            let location = CLLocation(latitude: latitude!, longitude: longitude!)
            self.institutions[row].updateAddress(location: location)
            complete()
        }
    }
}
