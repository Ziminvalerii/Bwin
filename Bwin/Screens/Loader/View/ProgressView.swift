//
//  ProgressView.swift
//  Bwin
//
//  Created by Tanya Koldunova on 20.10.2022.
//

import Foundation
import UIKit

@IBDesignable
class CustomProgreeView: UIView {
    var timer = Timer()
    private let progressLayer = CALayer()
    var progress: CGFloat = 0 {
        didSet {
            if progress <= 0 {
                stop()
            }
            setNeedsDisplay()
            //progressLayer.frame = CGRect(origin: .zero, size: CGSize(width: self.frame.width * progress, height: self.frame.height))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(progressLayer)
    }
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height*0.25).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = UIColor.orange.cgColor
    }
    
    func animate() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.progress += 0.2
        }
    }
    func stop() {
        timer.invalidate()
    }

}
