//
//  EditProfileVC.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/22/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditProfileVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBOutlet weak var statePickerView: UIPickerView!
    var statePicker: [String] = [String]()
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.statePickerView.delegate = self
        self.statePickerView.dataSource = self
        
        statePicker = ["NY","NJ","PA","CT","FL","MA","OR","AK"]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Auth.auth().currentUser != nil {
            user = FirebaseService.MS.user
        }
    
        nameTextField.text = user.name
        emailTextField.text = user.email
        streetTextField.text = user.street
        cityTextField.text = user.city
        zipcodeTextField.text = user.zipcode
        
        //add a way to get the current State form user and display that on state picker
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statePicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statePicker[row]
    }
    
    @IBAction func doneButtonWasPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearButtonWasPressed(_ sender: UIButton) {
        var favorite =  Dictionary<String, Bool>()
        for fav in user.favInstitutions {
            favorite[fav] = true
            print(fav)
        }
        print(favorite)
    }
    
    @IBAction func saveButtonWasPressed(_ sender: UIButton) {
        
        var name = user.name
        if nameTextField.text != "" {
            name = nameTextField.text!
        }
        
        var street = user.street
        if streetTextField.text != "" {
            street = streetTextField.text!
        }
        
        var city = user.city
        if cityTextField.text != "" {
            city = cityTextField.text!
        }
        
        var state = user.state
        let selectedValue = statePicker[statePickerView.selectedRow(inComponent: 0)]
        if state != selectedValue {
            state = selectedValue
        }
        
        var zipcode = user.zipcode
        if zipcodeTextField.text != "" {
            zipcode = zipcodeTextField.text!
        }
        
        var favorite =  Dictionary<String, Bool>()
        for fav in user.favInstitutions {
            favorite[fav] = true
        }
        
        let userData = ["name": name,
                        "street" : street,
                        "city" : city,
                        "state" : state,
                        "zipcode" : zipcode,
                        "provider" : user.provider,
                        "type" : user.type,
                        "favorite" : favorite] as [String : Any]
        
        FirebaseService.MS.saveUser(userData: userData)
        
        var email = user.email
        if emailTextField.text != user.email {
            email = emailTextField.text!
            
            Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
                if error != nil {
                    print(error as Any)
                } else {
                    print("success")
                }
            })
            
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
