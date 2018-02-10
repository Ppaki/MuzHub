//
//  RoundImageView.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/9/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    
}
