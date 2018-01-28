//
//  PostCollectionViewCell.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/2/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configCell() {
        
    }
}
