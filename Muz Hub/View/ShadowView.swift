//
//  ShadowView.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/9/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 7
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
