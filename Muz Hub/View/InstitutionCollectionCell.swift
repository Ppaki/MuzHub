//
//  InstitutionCollectionViewCell.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/2/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit

class InstitutionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    
    var _institute: Institution!
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configCell(institute: Institution) {
        self._institute = institute
    }
}
