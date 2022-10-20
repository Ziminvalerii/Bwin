//
//  InstructionViewController.swift
//  Bwin
//
//  Created by Tanya Koldunova on 18.10.2022.
//

import UIKit
import Lottie

class InstructionViewController: UIViewController {
    var model: InstructionModel.AllCases = InstructionModel.allCases
    var router: RouterProtocol!
    var currentIndex = 0 {
        didSet {
            tipLabel.text = model[currentIndex].description
          //  tipView.subviews.forEach({ $0.removeFromSuperview()})
            animationView = model[currentIndex].createView(frame: tipView.bounds)
            tipView.addSubview(animationView!)
            animationView?.play()
        }
    }
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipView: UIView!
    
    var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentIndex = 0
        // Do any additional setup after loading the view.
    }
    @IBAction func arrowRightPressed(_ sender: Any) {
        animationView?.stop()
        animationView?.removeFromSuperview()
        if currentIndex >= model.count - 1 {
            currentIndex = 0
        } else {
        currentIndex += 1
        }
        
        pressedButtonSound()
        
    }
    @IBAction func arrowLeftPressed(_ sender: Any) {
        animationView?.stop()
        animationView?.removeFromSuperview()
        if currentIndex <= 0 {
            currentIndex = model.count-1
        } else {
        currentIndex -= 1
        }
        
        pressedButtonSound()
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        pressedButtonSound()
        router.back()
    }
}
