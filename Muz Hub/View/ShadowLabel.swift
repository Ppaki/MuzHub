//
//  ShadowLabel.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/9/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit

class ShadowLabel: UILabel {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.masksToBounds = false
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
