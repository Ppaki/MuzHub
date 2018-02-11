//
//  ShadowCollectionViewCell.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/9/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit

class ShadowCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var salatNameLbl: UILabel!
    @IBOutlet weak var salatTimeLbl: UILabel!
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        layer.borderWidth = 1
    }
    
    func configCell(name: String, time: String) {
        self.salatNameLbl.text = name
        self.salatTimeLbl.text = time
    }
}
