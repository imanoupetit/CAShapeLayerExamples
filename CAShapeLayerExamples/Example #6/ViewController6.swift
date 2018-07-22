//
//  ViewController6.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 23/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

// Source: [Youtube.com / Brian Advent - "iOS Swift Tutorial: Cool Animations with Core Animation - Shaking Textfield & Pulse Animation"](https://www.youtube.com/watch?v=DNr5D7DSMr8)

import UIKit

class ViewController6: UIViewController {

    let orangeView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        orangeView.backgroundColor = .red
        orangeView.layer.cornerRadius = 100
        view.addSubview(orangeView)

        orangeView.translatesAutoresizingMaskIntoConstraints = false
        orangeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orangeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        orangeView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        orangeView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        let gesture = UITapGestureRecognizer(target: self, action: #selector(addPulse))
        orangeView.addGestureRecognizer(gesture)
    }

    @objc func addPulse() {
        //let pulse = Pulsing(numberOfPulses: 1, radius: 150, position: orangeView.center)
        let pulse = PulsingLayer(radius: 150, position: orangeView.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.red.cgColor
        view.layer.insertSublayer(pulse, below: orangeView.layer)
    }

}
