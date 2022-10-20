//
//  StartViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 12.10.2022.
//

import UIKit
import SpriteKit
import GameKit
import Lottie

class StartViewController: BaseViewController<StartPresenterProtocol>, StartViewProtocol {
    var router: RouterProtocol!
    private var openBonus: Bool = false {
        didSet {
            bonusView.isHidden = !openBonus
        }
    }
    @IBOutlet weak var bonusButton: UIButton!
    @IBOutlet weak var bonusView: UIView!
    @IBOutlet weak var bonusTitleImage: UIImageView!
    @IBOutlet weak var bonusSubtitleLabel: UILabel!
    @IBOutlet weak var bonusRewardLabel: UILabel!
    @IBOutlet weak var bonusAnimationView: LottieAnimationView! {
        didSet {
            bonusAnimationView.contentMode = .scaleAspectFit
            bonusAnimationView.loopMode = .playOnce
            bonusAnimationView.animationSpeed = 0.5
        }
    }
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var instructionButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
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
            //  view.sh
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        openBonus = false
        if let view = self.view as! SKView? {
            view.scene?.isPaused = false
        }
        configureBonusView()
        presenter.time = UserDefaultsValues.bonusDate.timeIntervalSince1970 - Date().timeIntervalSince1970
        presenter.startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let view = self.view as! SKView? {
            view.scene?.isPaused = true
        }
        presenter.stop()
    }
    
  
    func configureBonusView() {
        bonusTitleImage.image = Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 ? UIImage(named: "congratulation")! : UIImage(named: "waitTime")!
        bonusSubtitleLabel.text = Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 ? "You have recieved daily bonus " : "You have already recieved daily bonus. To recieve it again you need to wait"
        let fullString = NSMutableAttributedString(string: Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 ? "50" : presenter.timeString(time: presenter.time))
        if Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 {
            bonusButton.doGlowAnimation(withColor: .white, withEffect: .big)
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "coins.png")
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
        } else {
            bonusButton.removeGlowAnimation()
        }
        bonusRewardLabel.attributedText = fullString
    }
    
    func setBonusTime() {
        let fullString = NSMutableAttributedString(string: presenter.timeString(time: presenter.time))
        bonusRewardLabel.attributedText = fullString
    }
    
    private func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = { (vc, error) in
            if let vc = vc {
                self.present(vc, animated: true)
            } else {
                self.router.goToGameCenter()
            }
        }
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.goToSettings()
    }
    @IBAction func infoButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.goToInstruction()
    }
    @IBAction func startButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.createGame()
    }
    @IBAction func shopButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.goToShop()
    }
    
    @IBAction func closeBonusViewTapped(_ sender: Any) {
        pressedButtonSound()
        if Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 {
            UserDefaultsValues.bonusDate = Date().addingTimeInterval(86400)
            presenter.time = UserDefaultsValues.bonusDate.timeIntervalSince1970 - Date().timeIntervalSince1970
            presenter.startTimer()
        }
        openBonus = false
        configureBonusView()
        
    }
    @IBAction func openBonusTapped(_ sender: Any) {
        pressedButtonSound()
        openBonus = true
        if Date().timeIntervalSince1970 > UserDefaultsValues.bonusDate.timeIntervalSince1970 {
            congratulationSoundPlay()
            bonusAnimationView.play()
            UserDefaultsValues.coinsCount += 50
        }
       
    }
    @IBAction func gameCenterButtonPressed(_ sender: Any) {
        pressedButtonSound()
        if GKLocalPlayer.local.isAuthenticated {
            router.goToGameCenter()
        } else {
            authenticatePlayer()
        }
    }
    
}

extension StartViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}
