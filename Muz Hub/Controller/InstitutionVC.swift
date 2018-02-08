//
//  InstitutionVC.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 12/4/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation

class InstitutionVC: UIViewController {
    
    var institute: Institution!
    var institutionSchedule: InstitutionSchedule!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var fajrLabel: UILabel!
    @IBOutlet weak var zuhrLabel: UILabel!
    @IBOutlet weak var asrLabel: UILabel!
    @IBOutlet weak var maghribLabel: UILabel!
    @IBOutlet weak var ishaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if institutionSchedule == nil {
            
            loadSchedule {
                self.nameLabel.text = self.institute.name
                self.infoLabel.text = self.institute.info
                self.addressLabel.text = "\(self.institute.street) \n\(self.institute.city), \(self.institute.state) \(self.institute.zip)"
                
                self.fajrLabel.text = "Salat al-fajr: \(self.institutionSchedule.schedule["Salat al-fajr"]!)"
                self.zuhrLabel.text = "Salat al-zuhr: \(self.institutionSchedule.schedule["Salat al-zuhr"]!)"
                self.asrLabel.text = "Salat al-'asr: \(self.institutionSchedule.schedule["Salat al-'asr"]!)"
                self.maghribLabel.text = "Salat al-maghrib: \(self.institutionSchedule.schedule["Salat al-maghrib"]!)"
                self.ishaLabel.text = "Salat al-'isha: \(self.institutionSchedule.schedule["Salat al-'isha"]!)"
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadSchedule(complete: @escaping DownloadCompleted) {
        let ref = Database.database().reference()
        ref.child("institution").child(institute.id).child("schedule").observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            self.institutionSchedule = InstitutionSchedule(id: self.institute.id, schedule: value!)
            complete()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
