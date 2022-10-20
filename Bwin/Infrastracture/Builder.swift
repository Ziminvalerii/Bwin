//
//  Builder.swift
//  BitFair
//
//  Created by Tanya Koldunova on 14.09.2022.
//

import Foundation

protocol BuilderProtocol {
    func resolveGameViewController(router: RouterProtocol, connectionManager: PeerConnectivityManager) -> GameViewController
    func resolveStartViewController(router: RouterProtocol) -> StartViewController
    func resolveCreateGameViewController(router: RouterProtocol) -> CreateGameViewController
    func resolveSettingsViewController(router:RouterProtocol) -> SettingsViewController
    func resolveShopViewController(router: RouterProtocol)-> ShopViewController
    func resolveInstructionViewController(router: RouterProtocol)-> InstructionViewController
    func resolveLoaderViewController(router: RouterProtocol) -> LoaderViewController 
}

class Builder: BuilderProtocol {
    
    func resolveGameViewController(router: RouterProtocol, connectionManager: PeerConnectivityManager) -> GameViewController {
        let vc = GameViewController.instantiateMyViewController(name: .game)
        vc.connectionManager = connectionManager
        vc.router = router
      //  vc.presenter = GamePresenter(view: vc, router: router, adManager: AdsManager())
        return vc
    }
    
    func resolveStartViewController(router: RouterProtocol) -> StartViewController {
        let vc = StartViewController.instantiateMyViewController(name: .start)
        vc.presenter = StartPresenter(view: vc)
        vc.router = router
        return vc
    }
    
    func resolveCreateGameViewController(router: RouterProtocol) -> CreateGameViewController {
        let vc = CreateGameViewController.instantiateMyViewController(name: .createGame)
        vc.router = router
        vc.connectionManager = PeerConnectivityManager()
        return vc
    }
    
    func resolveSettingsViewController(router:RouterProtocol) -> SettingsViewController {
        let vc = SettingsViewController.instantiateMyViewController(name: .settings)
        vc.router = router
        return vc
    }
    
    func resolveShopViewController(router: RouterProtocol)-> ShopViewController {
        let vc = ShopViewController.instantiateMyViewController(name: .shop)
        vc.router = router
        return vc
    }
    
    func resolveInstructionViewController(router: RouterProtocol)-> InstructionViewController {
        let vc = InstructionViewController.instantiateMyViewController(name: .instruction)
        vc.router = router
        return vc
    }
    
    func resolveLoaderViewController(router: RouterProtocol) -> LoaderViewController {
        let vc = LoaderViewController.instantiateMyViewController(name: .loader)
        vc.router = router
        return vc
    }
}
