//
//  RoundedCornerButton.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 1/28/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit

class RoundedCornerButton: UIButton {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        //self.layer.cornerRadius = self.frame.height / 2
        
        layer.cornerRadius = frame.size.height / 2
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
