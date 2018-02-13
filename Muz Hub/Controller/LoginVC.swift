//
//  LoginVC.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/12/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    var delegate: CenterVCDelegate?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonWasPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil {
                print("getting user....")
                FirebaseService.MS.getUser()
                showVC = .HomeVC
                self.delegate?.reloadContainer()
            } else {
                print(error! as NSError)
            }
        }
    }
    
    @IBAction func registerButtonWasPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
            } else {
                print(error as! String)
            }
        }
    }
    
    @IBAction func menuButtonWasPressed(_ sender: UIButton) {
        delegate?.toggleLeftPanel()
    }
    
}
