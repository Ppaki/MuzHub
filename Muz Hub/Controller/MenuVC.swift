//
//  MenuVC.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/12/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuVC: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid != nil {
            loginButton.isHidden = true
        } else {
            profileButton.isHidden = true
        }
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        present(profileVC!, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func mapViewButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mapVC = storyboard.instantiateViewController(withIdentifier: "MapVC") as? MapVC
        present(mapVC!, animated: true, completion: nil)
    }
    
}
