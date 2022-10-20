//
//  ShipViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 18.10.2022.
//

import UIKit

class ShopViewController: UIViewController {
    var router: RouterProtocol!
    var model: ShopNodel.AllCases = ShopNodel.allCases
    var currentIndex = 0 {
        didSet {
            ballImage.image = model[currentIndex].image
            buyButton.setTitle((UserDefaultsValues.currentBall == model[currentIndex]) ? "Current" : UserDefaultsValues.availableBalls.contains( model[currentIndex]) ? "Get" : "Buy", for: .normal)
            ballPriceLabel.text = model[currentIndex].price.description
            ballPriceLabel.isHidden = model[currentIndex].price == 0
            coinImage.isHidden = model[currentIndex].price == 0
        }
    }
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var ballImage: UIImageView!
    @IBOutlet weak var ballPriceLabel: UILabel!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var leftArrow: UIButton!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var coinsCountLabel: UILabel! {
        didSet {
            coinsCountLabel.text = "Coins count: \(UserDefaultsValues.coinsCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = model.firstIndex(of: UserDefaultsValues.currentBall)!
        // Do any additional setup after loading the view.
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "You don`t have enough coins", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Got it", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    private func showBuyAlert() {
        let alertController = UIAlertController(title: "Are you sure you want buy this ball?", message: "", preferredStyle: .alert)
        let buyAction = UIAlertAction(title: "Yes", style: .default) { action in
            UserDefaultsValues.coinsCount -= self.model[self.currentIndex].price
            UserDefaultsValues.availableBalls.append(self.model[self.currentIndex])
            self.buyButton.setTitle((UserDefaultsValues.currentBall == self.model[self.currentIndex]) ? "Current" : UserDefaultsValues.availableBalls.contains(self.model[self.currentIndex]) ? "Get" : "Buy", for: .normal)
            self.coinsCountLabel.text = "Coins count: \(UserDefaultsValues.coinsCount)"
            alertController.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(cancel)
        alertController.addAction(buyAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func buyButtonPressed(_ sender: Any) {
        pressedButtonSound()
        if buyButton.titleLabel?.text == "Buy" {
            if UserDefaultsValues.coinsCount >= model[currentIndex].price {
               showBuyAlert()
            } else {
                showAlert()
            }
        } else if buyButton.titleLabel?.text == "Get" {
            UserDefaultsValues.currentBall = model[currentIndex]
            buyButton.setTitle((UserDefaultsValues.currentBall == model[currentIndex]) ? "Current" : UserDefaultsValues.availableBalls.contains( model[currentIndex]) ? "Get" : "Buy", for: .normal)
        }
    }
    @IBAction func rightArrowTapped(_ sender: Any) {
        if currentIndex >= model.count - 1 {
            currentIndex = 0
        } else {
        currentIndex += 1
        }
        
        pressedButtonSound()
    }
    @IBAction func leftArrowTapped(_ sender: Any) {
        if currentIndex <= 0 {
            currentIndex = model.count-1
        } else {
        currentIndex -= 1
        }
        
        pressedButtonSound()
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        pressedButtonSound()
        router.back()
    }
    
}
