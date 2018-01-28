//
//  ContainerViewController.swift
//  Muz Hub
//
//  Created by Aqib Shehri on 11/10/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit
import QuartzCore

enum menuPop {
    case popMenu
    case closeMenu
}

enum ShowWhichVC {
    case homeViewController
}

var showVC: ShowWhichVC = .homeViewController

class ContainerViewController: UITabBarController {
    
    var homeVC: HomeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func initCenter(screen: ShowWhichVC) {
        var presentingController: UIViewController!
        showVC = screen
        
        if homeVC == nil {
            homeVC = UIStoryboard.HomeViewController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension UIStoryboard {
    class func mainStorybroad() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func menuViewController() -> MenuViewController? {
        return mainStorybroad().instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
    }
    
    class func HomeViewController() -> HomeViewController? {
        return mainStorybroad().instantiateViewController(withIdentifier: "HomeViewcontroller") as? HomeViewController
    }
}
