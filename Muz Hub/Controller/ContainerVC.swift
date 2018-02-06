//
//  ViewController.swift
//
//  Created by Aqib Shehri on 11/12/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit

enum MenuState {
    case menuClose
    case menuOpen
}

enum ShowWhichVC {
    case HomeVC
}

var showVC: ShowWhichVC = .HomeVC

class ContainerVC: UIViewController {
    
    var homeVC: HomeVC!
    var menuVC: MenuVC!
    
    var centerController: UIViewController!
    var currentState: MenuState = .menuClose {
        didSet {
            let shouldShowShadow = (currentState != .menuClose)
            showShadowForCenterController(status: shouldShowShadow)
        }
    }
    
    var isHidden = false
    let centerPanelExpandedOffset: CGFloat = 160
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
    
    func initCenter(screen: ShowWhichVC) {
        
        var presentingController: UIViewController!
        
        if screen == ShowWhichVC.HomeVC {
            showVC = screen
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
            presentingController = homeVC
        }
        
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        
        centerController = presentingController
        
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
    }
}

extension ContainerVC: CenterVCDelegate {

    func changeVC(newController: ShowWhichVC) {
        //initCenter(screen: newController)
    }
    
    func toggleLeftPanel() {
        let menuNotOpen = (currentState != .menuOpen)
        
        if menuNotOpen {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpend: menuNotOpen)
    }
    
    func addLeftPanelViewController() {
        if menuVC == nil {
            menuVC = UIStoryboard.menuVC()
            addChildSidePanelViewController(menuVC!)
        }
    }
    
    func addChildSidePanelViewController(_ sidePanelController: MenuVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    @objc func animateLeftPanel(shouldExpend: Bool) {
        if currentState == .menuClose {
            isHidden = !isHidden
            setWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
            currentState = .menuOpen
        } else {
            isHidden = !isHidden
            hideWhiteCoverView()
            animateCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
                if finished == true {
                    self.currentState = .menuClose
                    self.menuVC = nil
                }
            })
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func setWhiteCoverView() {
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2) {
            whiteCoverView.alpha = 0.75
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.animateLeftPanel(shouldExpend:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
        
    }
    
    func hideWhiteCoverView() {
        self.centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews {
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    
    func showShadowForCenterController(status: Bool) {
        if status == true {
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
}

private extension UIStoryboard {
    class func mainStorybroad() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func menuVC() -> MenuVC? {
        return mainStorybroad().instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
    }
    
    class func homeVC() -> HomeVC? {
        return mainStorybroad().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
}

