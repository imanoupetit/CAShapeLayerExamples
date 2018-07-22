//
//  ClockShapeLayer.swift
//  TimerButtonApp
//
//  Created by Imanou on 22/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class ClockShapeLayer: CAShapeLayer {

    private let hourHand = CAShapeLayer()
    private let minuteHand = CAShapeLayer()
    var date = Date()

    override init() {
        super.init()

        bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        path = UIBezierPath(ovalIn: bounds).cgPath
        fillColor = UIColor.orange.cgColor
        strokeColor = UIColor.black.cgColor
        lineWidth = 4

        hourHand.path = UIBezierPath(roundedRect: CGRect(x: -2, y: -70, width: 4, height: 70), cornerRadius: 3).cgPath
        hourHand.fillColor = UIColor.black.cgColor
        hourHand.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        addSublayer(hourHand)

        minuteHand.path = UIBezierPath(roundedRect: CGRect(x: -1, y: -90, width: 2, height: 90), cornerRadius: 3).cgPath
        minuteHand.fillColor = UIColor.black.cgColor
        minuteHand.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        addSublayer(minuteHand)

        update()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(by minutes: Int = 0) {
        let calendar = Calendar.current
        date = calendar.date(byAdding: .minute, value: minutes, to: date)!
        let components = calendar.dateComponents([.minute, .hour], from: date)
        hourHand.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(components.hour!) / 12 * .pi * 2))
        minuteHand.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(components.minute!) / 60 * .pi * 2))
    }

}
