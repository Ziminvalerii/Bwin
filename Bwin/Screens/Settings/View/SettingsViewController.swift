//
//  SettingsViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 14.10.2022.
//

import UIKit
import SpriteKit

class SettingsViewController: UIViewController {
    var router: RouterProtocol!
    @IBOutlet weak var containerImageView: UIImageView!
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var sliderBackground: UIImageView!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.setThumbImage(UIImage(named: "thumbTexture")!, for: .normal)
            slider.value = UserDefaultsValues.brightness
        }
    }
    @IBOutlet weak var soundCell: SettingsCell! {
        didSet {
            soundCell.configure(model: .sound)
        }
    }
    @IBOutlet weak var musicCell: SettingsCell! {
        didSet {
            musicCell.configure(model: .music)
        }
    }
    @IBOutlet weak var vibrationCell: SettingsCell! {
        didSet {
            vibrationCell.configure(model: .vibration)
        }
    }
    @IBOutlet weak var privacyPolicyCell: SettingsCell! {
        didSet {
            privacyPolicyCell.router = router
            privacyPolicyCell.configure(model: .privacyPolicy)
        }
    }
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "StartScene") as? StartScene {
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func sliderValueChange(_ sender: Any) {
        UserDefaultsValues.brightness = Float(slider.value)
        UIScreen.main.brightness = CGFloat(UserDefaultsValues.brightness)
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.back()
    }
    
}
