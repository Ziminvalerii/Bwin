//
//  SettingsCell.swift
//  Bwin
//
//  Created by Tanya Koldunova on 13.10.2022.
//

import UIKit


@IBDesignable
class SettingsCell: UIView {
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    private var model: SettingsModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    func configureView() {
        guard let view = loadFromNib(nib: SettingsCell.self) else {return}
        view.frame = self.bounds
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        addSubview(view)
    }
//    convenience init() {
//        let size = CGSize(width: 79, height: 87)
//        self.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
//        guard let view = loadFromNib(nib: SettingsCell.self) else {return}
//        view.frame = self.frame
//        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
//        addSubview(view)
//    }
    
    func configure(model: SettingsModel) {
        self.model = model
        titleLabel.text = model.title
        changeButton.setImage(model.isOn ? model.onImage : model.offImage, for: .normal)
    }
    @IBAction func changeButtonPressed(_ sender: Any) {
        guard let model = model else {return}
        model.valueChanged()
        changeButton.setImage(model.isOn ? model.onImage : model.offImage, for: .normal)
    }
    
}
