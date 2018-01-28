//
//  InstitutionVC.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 12/4/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit

class InstitutionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var institute: Institution!
    var scheduleKeys: Array<String>!
    var scheduleValues: Array<String>!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    
        nameLabel.text = institute.name
        addressLabel.text = "\(institute.street) \n\(institute.city), \(institute.state) \(institute.zip)"
        infoLabel.text = institute.info
        
        loadSchedule()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scheduleKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schedule", for: indexPath)
        cell.textLabel?.text = "\(self.scheduleKeys[indexPath.row]): \(self.scheduleValues[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func loadSchedule() {
        self.scheduleKeys = self.institute.schedule.allKeys as! Array<String>
        self.scheduleValues = self.institute.schedule.allValues as! Array<String>
        tableView.reloadData()
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
