//
//  Router.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import UIKit
import GameKit

protocol RouterProtocol {
    var navigationController: UINavigationController {get set}
    var builder: BuilderProtocol {get set}
    func start()
    func goToGame(connectionManager: PeerConnectivityManager)
    func createGame()
    func goToGameCenter()
    func goToSettings()
    func goToInstruction()
    func goToPrivacyPolicy()
    func goToShop()
    func back()
    func dissmiss()
}


class Router: RouterProtocol {
    var navigationController: UINavigationController
    
    var builder: BuilderProtocol
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    func load() {
        let vc = builder.resolveLoaderViewController(router: self)
        navigationController.viewControllers = [vc]
    }
    func start() {
        let vc = builder.resolveStartViewController(router: self)
        navigationController.viewControllers = [vc]
    }
    
    func goToGame(connectionManager: PeerConnectivityManager) {
        let vc = builder.resolveGameViewController(router: self, connectionManager: connectionManager)
     //   let navVC = NavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
      //  self.navigationController = navVC
       // self.navigationController.pushViewController(vc, animated: true)
    }
    
    func createGame() {
        let vc = builder.resolveCreateGameViewController(router: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func back() {
        self.navigationController.popViewController(animated: true)
    }
    
    func goToInstruction() {
        let vc = builder.resolveInstructionViewController(router: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func goToSettings() {
        let viewController = builder.resolveSettingsViewController(router: self)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToShop() {
        let vc = builder.resolveShopViewController(router: self)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func goToPrivacyPolicy() {
        guard let url = URL(string: "https://docs.google.com/document/d/1QuVUi0iYEmCjfiKLZzRZie9qLDizZXzXE6ZQ7hMrM9M/edit?usp=sharing") else {return}
        let vc = builder.resolvePrivacyPolicy(url: url)
        vc.modalPresentationStyle = .formSheet
        self.navigationController.present(vc, animated: true)
    }
    
    func goToGameCenter() {
        let gcVC = GKGameCenterViewController(leaderboardID: "com.jonokoltd.bwin.Leaderboard", playerScope: .global, timeScope: .allTime)
        if let vc = navigationController.topViewController as? StartViewController {
            gcVC.gameCenterDelegate = vc
        }
        navigationController.present(gcVC, animated: true)
    }
    
    func dissmiss() {
        self.navigationController.dismiss(animated: true)
    }
    
    
}
