//
//  ViewController5.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 22/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

// Source: [Youtube.com / Brian Advent - "iOS Swift Tutorial: Cool Animations with Core Animation - Shaking Textfield & Pulse Animation"](https://www.youtube.com/watch?v=DNr5D7DSMr8)

import UIKit

class ViewController5: UIViewController, UITextFieldDelegate {

    let shakingTextField = ShakingTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        view.addSubview(shakingTextField)

        shakingTextField.delegate = self
        shakingTextField.borderStyle = .roundedRect
        shakingTextField.translatesAutoresizingMaskIntoConstraints = false
        shakingTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shakingTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        shakingTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        shakingTextField.shake()
    }

}
