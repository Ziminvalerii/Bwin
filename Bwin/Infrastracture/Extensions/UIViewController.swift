//
//  UIViewController.swift
//  BitFair
//
//  Created by Tanya Koldunova on 13.09.2022.
//

import UIKit

extension UIViewController {

    static func instantiateMyViewController(name: ViewControllerKeys) -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name.rawValue) as! Self
        return vc
    }
}

enum ViewControllerKeys: String {
    case game = "Game"
    case start = "Start"
    case createGame = "Create Game"
    case shop = "Shop"
    case settings = "Settings"
    case instruction = "Instruction"
    case loader = "Loader"
}

class NavigationController: UINavigationController {
    override var shouldAutorotate: Bool {
        return true// topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
