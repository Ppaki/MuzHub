//
//  ViewController.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/10/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var institute: Institution!
    var institutionSchedule: InstitutionSchedule!
    var scheduleName: [String]!
    var scheduleTime: [String]!
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collection.delegate = self
        collection.dataSource = self
        
        if institute != nil {
            loadSchedule {
                self.nameLabel.text = self.institute.name
                self.addressLabel.text = "\(self.institute.street) | \(self.institute.city), \(self.institute.state) \(self.institute.zip)"
                
                self.scheduleName = self.institutionSchedule.schedule.allKeys as! [String]
                self.scheduleTime = self.institutionSchedule.schedule.allValues as! [String]
                self.collection.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if institutionSchedule != nil {
            return institutionSchedule.schedule.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "prayer", for: indexPath) as? ShadowCollectionViewCell
        
        cell?.configCell(name: scheduleName[indexPath.row], time: scheduleTime[indexPath.row])
        
        return cell!
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
