//
//  CenterVCDelegate.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/10/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func reloadContainer()
    func animateLeftPanel(shouldExpend: Bool)
}
