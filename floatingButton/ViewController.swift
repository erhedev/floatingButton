//
//  ViewController.swift
//  floatingButton
//
//  Created by Erik Hede on 2019-05-20.
//  Copyright © 2019 Erik Hede. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 250, width: 100, height: 50)
        button.backgroundColor = .blue
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        button.titleLabel?.textAlignment = .center//Text alighment center
        button.titleLabel?.numberOfLines = 0//To display multiple lines in UIButton
        button.titleLabel?.lineBreakMode = .byWordWrapping//By word wrapping
        button.tag = 1//To assign tag value
        button.btnProperties()//Call UIButton properties from extension function
        button.setAllSideShadow(shadowShowSize: 10.0)
        button.makeFloating()
        button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonClicked(sender:UIButton) {
        print("Button \(sender.tag) clicked")
    }
    
}

extension UIButton {
    func btnProperties() {
        layer.cornerRadius = 10//Set button corner radious
        clipsToBounds = true
        backgroundColor = .blue//Set background colour
        //titleLabel?.textAlignment = .center//add properties like this
    }
    func makeFloating() {
        let horizontalEffect = UIInterpolatingMotionEffect(
            keyPath: "layer.shadowOffset.width",
            type: .tiltAlongHorizontalAxis)
        horizontalEffect.minimumRelativeValue = 16
        horizontalEffect.maximumRelativeValue = -16
        
        let verticalEffect = UIInterpolatingMotionEffect(
            keyPath: "layer.shadowOffset.height",
            type: .tiltAlongVerticalAxis)
        verticalEffect.minimumRelativeValue = 16
        verticalEffect.maximumRelativeValue = -16
        
        let effectGroup = UIMotionEffectGroup()
        effectGroup.motionEffects = [ horizontalEffect,
                                      verticalEffect ]
        self.addMotionEffect(effectGroup)
    }
    
    func setAllSideShadow(shadowShowSize: CGFloat = 1.0) { // this method adds shadow to allsides
        let shadowSize : CGFloat = shadowShowSize
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
}
