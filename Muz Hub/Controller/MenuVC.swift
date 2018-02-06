//
//  MenuVC.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/12/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    
    var isLogedIn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid != nil {
            isLogedIn = true
            loginButton.titleLabel?.text = "logout"
            profileButton.isHidden = false
        } else {
            isLogedIn = false
            profileButton.isHidden = true
            loginButton.titleLabel?.text = "Login /sign-up"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        present(profileVC!, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if !isLogedIn {
            login()
        } else {
            logout()
        }
    }
    
    @IBAction func mapViewButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mapVC = storyboard.instantiateViewController(withIdentifier: "MapVC") as? MapVC
        present(mapVC!, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("could not signout: @%", error)
        }
    }
    
    // MARK: - helper
    
    func login() {
        isLogedIn = !isLogedIn
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        present(loginVC!, animated: true, completion: nil)
    }
    
    func logout() {
        isLogedIn = !isLogedIn
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("could not signout: @%", error)
        }
    }
    
    // MARK: - tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        
        return cell!
    }
}
