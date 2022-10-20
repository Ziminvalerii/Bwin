//
//  LoaderViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 20.10.2022.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {
    var router: RouterProtocol!
    @IBOutlet weak var lottieAnimationView: LottieAnimationView! {
        didSet {
            lottieAnimationView.contentMode = .scaleToFill
            lottieAnimationView.loopMode = .loop
            lottieAnimationView.animationSpeed = 0.5
        }
    }
    @IBOutlet weak var progressView: CustomProgreeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.animate()
        lottieAnimationView.play()
        //(UIApplication.shared.delegate as? AppDelegate).w
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute: {
            let rootNavVC = NavigationController()
            self.router.navigationController = rootNavVC
            self.router.start()
            (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = rootNavVC
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("disapear")
    }

}
