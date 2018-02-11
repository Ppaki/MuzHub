//
//  FeedCollectionViewCell.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 2/11/18.
//  Copyright © 2018 Aqib Shehri. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var masjidImage: RoundImageView!
    @IBOutlet weak var masjidNameLbl: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLbl: UILabel!
    
    
    required init? (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func configCell() {
        
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
    
    }
    
    
    @IBAction func masjidInfoButtonPressed(_ sender: UIButton) {
        
    }
    
}
