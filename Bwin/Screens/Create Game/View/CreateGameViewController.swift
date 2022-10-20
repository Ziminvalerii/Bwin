//
//  CreateGameViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 13.10.2022.
//

import UIKit

class CreateGameViewController: UIViewController {
    var router: RouterProtocol!
    var connectionManager: PeerConnectivityManager!
    @IBOutlet weak var cointsLabel: UILabel! {
        didSet {
            cointsLabel.text = "Coins count: \(UserDefaultsValues.coinsCount.description)"
        }
    }
    @IBOutlet weak var bestScoreLabel: UILabel! {
        didSet {
            bestScoreLabel.text = "Best score: \(UserDefaultsValues.bestScore.description)"
        }
    }
    @IBOutlet weak var segmentControl: UISegmentedControl! {
        didSet {
            let selectedTitleAtributes = [NSAttributedString.Key.font : UIFont(name: "Hoefler Text Black Italic", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.white]
            let unSelectedTitleAtributes = [NSAttributedString.Key.font : UIFont(name: "Hoefler Text Black Italic", size: 17)!, NSAttributedString.Key.foregroundColor: UIColor.brown]
            segmentControl.setTitleTextAttributes(selectedTitleAtributes, for: .selected)
            segmentControl.setTitleTextAttributes(unSelectedTitleAtributes, for: .normal)
            segmentControl.setBackgroundImage(UIImage(ciImage: .clear), for: .normal, barMetrics: .default)
            segmentControl.setBackgroundImage(UIImage(named: "buttonTexture"), for: .selected, barMetrics: .default)
            segmentControl.setBackgroundImage(UIImage(named: "buttonTexture"), for: .highlighted, barMetrics: .default)
            segmentControl.setBackgroundImage(UIImage(named: "buttonTexture"), for: [.highlighted, .selected], barMetrics: .default)
        }
    }
    @IBOutlet weak var sliderContainer: UIImageView!
    @IBOutlet weak var stakeLabel: UILabel!
    @IBOutlet weak var sliderBackground: UIImageView!
    @IBOutlet weak var stakeSlider: UISlider! {
        didSet {
            stakeSlider.setThumbImage(UIImage(named: "thumbTexture")!, for: .normal)
        }
    }
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    var stake: Int? {
        didSet {
            if let stake = stake {
                UserDefaultsValues.stake = stake
                startGameButton.titleLabel?.alpha = (stake > UserDefaultsValues.coinsCount) ? 0.5 : 1
                stakeLabel.text = "Your stake: \(stake)"
            }
            
        }
    }
    var currentState: Int = 0{
        didSet {
            if currentState == 0 {
                sliderContainer.isHidden = false
                stakeLabel.isHidden = false
                stakeSlider.isHidden = false
                sliderBackground.isHidden = false
                startGameButton.setTitle("Start game", for: .normal)
                stake = Int(stakeSlider.value)
            } else {
                sliderContainer.isHidden = true
                stakeLabel.isHidden = true
                stakeSlider.isHidden = true
                sliderBackground.isHidden = true
                startGameButton.setTitle("Join the game", for: .normal)
                startGameButton.titleLabel?.alpha = 1.0
                stake = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        currentState = segmentControl.selectedSegmentIndex
        connectionManager.connectionDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cointsLabel.text = "Coins count: \(UserDefaultsValues.coinsCount.description)"
        bestScoreLabel.text = "Best score: \(UserDefaultsValues.bestScore.description)"
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "You don`t have enough coins", message: "You dont have enough coins to start this game. Please, connect to game with smaller stake", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        pressedButtonSound()
        currentState = segmentControl.selectedSegmentIndex
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        stake = Int(stakeSlider.value)
        //stakeLabel.text = "Your stake: \(Int(stakeSlider.value))"
    }
    @IBAction func startGamePressed(_ sender: Any) {
        pressedButtonSound()
        if startGameButton.titleLabel!.text == "Start game" {
            guard let stake = stake else {showAlert(); return}
            if stake <= UserDefaultsValues.coinsCount {
            connectionManager.presentMCBrowser(from: self)
            } else {
                showAlert()
            }
        } else if startGameButton.titleLabel!.text == "Join the game" {
            connectionManager.startAdvertisingPeer(parentVC: self)
        }
        //router.goToGame()
    }
    @IBAction func bacjButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.back()
    }
    
}

extension CreateGameViewController: ConnectionProtocol {
    func connected() {
        router.goToGame(connectionManager: connectionManager)
    }
    
    
}
