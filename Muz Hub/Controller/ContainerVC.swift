//
//  ViewController.swift
//
//  Created by Aqib Shehri on 11/12/17.
//  Copyright © 2017 Aqib Shehri. All rights reserved.
//

import UIKit
import FirebaseAuth

enum MenuState {
    case menuClose
    case menuOpen
}

enum ShowWhichVC {
    case HomeVC
    case ProfileVC
    case LoginVC
    case MapVC
}

var showVC: ShowWhichVC = .HomeVC

class ContainerVC: UIViewController {
    
    var homeVC: HomeVC!
    var profileVC: ProfileVC!
    var loginVC: LoginVC!
    var mapVC: MapVC!
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var centerController: UIViewController!
    var isHidden = false
    let centerPanelExpandedOffset: CGFloat = 160
    var tap: UITapGestureRecognizer!
    
    var currentState: MenuState = .menuClose {
        didSet {
            let shouldShowShadow = (currentState != .menuClose)
            showShadowForCenterController(status: shouldShowShadow)
        }
    }
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        initCenter(screen: showVC)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
    
    //MARK: - ib action buttons
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        showVC = .LoginVC
        initCenter(screen: showVC)
        toggleLeftPanel()
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            showVC = .LoginVC
            initCenter(screen: showVC)
            toggleLeftPanel()
        } catch let error as NSError  {
            print(error)
        }
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
        showVC = .ProfileVC
        initCenter(screen: showVC)
        toggleLeftPanel()
    }
    
    @IBAction func mapButtonPressed(_ sender: UIButton) {
        showVC = .MapVC
        initCenter(screen: showVC)
        toggleLeftPanel()
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        showVC = .HomeVC
        initCenter(screen: showVC)
        toggleLeftPanel()
    }
    
    // MARK: - Helper
    func initCenter(screen: ShowWhichVC) {
        
        var presentingController: UIViewController!
        
        if screen == ShowWhichVC.HomeVC {
            showVC = screen
            homeVC = UIStoryboard.homeVC()
            homeVC.delegate = self
            presentingController = homeVC
            
        } else if screen == ShowWhichVC.ProfileVC {
            showVC = screen
            profileVC = UIStoryboard.profileVC()
            profileVC.delegate = self
            presentingController = profileVC
            
        } else if screen == ShowWhichVC.MapVC {
            showVC = screen
            mapVC = UIStoryboard.mapVC()
            mapVC.delegate = self
            presentingController = mapVC
            
        } else if screen == ShowWhichVC.LoginVC {
            showVC = screen
            loginVC = UIStoryboard.loginVC()
            loginVC.delegate = self
            presentingController = loginVC
            
        }
        
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        
        centerController = presentingController
        
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
        
        if Auth.auth().currentUser != nil {
            self.loginButton.isHidden = true
            self.logoutButton.isHidden = false
        } else {
            self.loginButton.isHidden = false
            self.logoutButton.isHidden = true
        }
    }
}

extension ContainerVC: CenterVCDelegate {
    func reloadContainer() {
        initCenter(screen: showVC)
    }
    
    func toggleLeftPanel() {
        let menuNotOpen = (currentState != .menuOpen)
        
        if menuNotOpen {
            
        }
        animateLeftPanel(shouldExpend: menuNotOpen)
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
    
    class func homeVC() -> HomeVC? {
        return mainStorybroad().instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    }
    
    class func profileVC() -> ProfileVC? {
        return mainStorybroad().instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
    }
    
    class func mapVC() -> MapVC? {
        return mainStorybroad().instantiateViewController(withIdentifier: "MapVC") as? MapVC
    }
    
    class func loginVC() -> LoginVC? {
        return mainStorybroad().instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
    }
}

