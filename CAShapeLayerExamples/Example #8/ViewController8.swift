//
//  ViewController8.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 25/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

import UIKit

class ViewController8: UIViewController {

    let statusView = StatusView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(statusView)

        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        statusView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        statusView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        statusView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        statusView.startPulse()
    }

}

import UIKit

final class StatusView: UIView {

    private static let widthConstant: CGFloat = 10
    var color: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        color = .lightGray
        super.init(frame: frame)

        backgroundColor = .clear
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: StatusView.widthConstant, height: StatusView.widthConstant)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let ovalPath = UIBezierPath(ovalIn: rect)
        color.setFill()
        ovalPath.fill()
    }

    func startPulse() {
        guard layer.animation(forKey: "animateOpacity") == nil else { return }

        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.fillMode = CAMediaTimingFillMode.forwards
        pulseAnimation.isRemovedOnCompletion = false
        pulseAnimation.duration = 0.8
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude

        layer.add(pulseAnimation, forKey: "animateOpacity")
    }

    func stopPulse() {
        layer.removeAnimation(forKey: "animateOpacity")
    }

}
