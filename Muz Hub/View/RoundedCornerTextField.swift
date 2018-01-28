//
//  RoundedCornerTextField.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/15/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit

class RoundedCornerTextField: UITextField {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
