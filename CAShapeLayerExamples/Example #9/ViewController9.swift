//
//  ViewController9.swift
//  CAShapeLayerExamples
//
//  Created by Imanou on 25/07/2018.
//  Copyright © 2018 Imanou Petit. All rights reserved.
//

/*
Sources:
- [thinkandbuild.it](http://www.thinkandbuild.it/how-to-build-a-custom-control-in-ios/)
- [github.com/ariok](https://github.com/ariok/TB_CircularSlider)
*/

// Note: this code does not use CALayer/CAShapeLayer but shows a possible animation for views.

import UIKit

class ViewController9: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let slider = CircularSlider(frame: view.bounds)
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(updateValue), for: .valueChanged)
    }

    @objc func updateValue(_ slider: CircularSlider) {
        print("Value changed \(slider.angle)")
    }

}

import UIKit

class CircularSlider: UIControl {

    private static let lineWidth: CGFloat = 40
    private let label = UILabel()
    private lazy var radius: CGFloat = (frame.size.width - layoutMargins.left - layoutMargins.right) / 2
    var angle: Int {
        didSet {
            if angle != oldValue {
                UISelectionFeedbackGenerator().selectionChanged()
                label.text = "\(angle)"
                setNeedsDisplay()
                sendActions(for: UIControl.Event.valueChanged)
            }
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        angle = Int(Measurement(value: 2 * .pi, unit: UnitAngle.radians).converted(to: .degrees).value.rounded(.down)) // 360

        super.init(frame: frame)

        let margin: CGFloat = 60
        layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        backgroundColor = UIColor.yellow

        let font = UIFont.boldSystemFont(ofSize: 50)
        let str: NSString = "000"
        let fontSize = str.size(withAttributes: [NSAttributedString.Key.font : font])
        label.isUserInteractionEnabled = false
        label.frame = CGRect(x: (frame.size.width  - fontSize.width) / 2 , y: (frame.size.height - fontSize.height) / 2 , width: fontSize.width, height: fontSize.height)
        label.textColor = UIColor.blue
        label.textAlignment = .center
        label.font = font
        label.text = "\(angle)"
        addSubview(label)

        UISelectionFeedbackGenerator().prepare()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Track touches

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)

        // Calculate the direction in degrees from a center point to an arbitrary position
        let lastPoint = touch.location(in: self)
        let centerPoint = CGPoint(x: frame.midX, y: frame.midY)
        var v = CGPoint(x: lastPoint.x - centerPoint.x, y: lastPoint.y - centerPoint.y)
        let vmag = pow(pow(v.x, 2) + pow(v.y, 2), 2)
        v.x /= vmag
        v.y /= vmag
        let radians = atan2(v.y, v.x)
        let result = Measurement(value: Double(radians), unit: UnitAngle.radians).converted(to: .degrees).value
        let currentAngle = (result >= 0 ? result : result + 360)
        let angleInt = Int(currentAngle.rounded(.down))
        angle = Int(360 - angleInt)

        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
    }

    // MARK: - Draw

    override func draw(_ rect: CGRect){
        guard let ctx = UIGraphicsGetCurrentContext() else { return }

        /** Draw the Background **/

        ctx.addArc(center: CGPoint(x: frame.midX, y: frame.midY), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        UIColor.blue.set()

        ctx.setLineWidth(CircularSlider.lineWidth + 10)
        ctx.setLineCap(.butt)
        ctx.drawPath(using: .stroke)

        /** Draw the circle **/

        /** Create THE MASK Image **/
        UIGraphicsBeginImageContext(CGSize(width: bounds.size.width, height: bounds.size.height))
        guard let imageCtx = UIGraphicsGetCurrentContext() else { return }

        let endAngle = CGFloat(Measurement(value: Double(angle), unit: UnitAngle.degrees).converted(to: .radians).value)
        imageCtx.addArc(center: CGPoint(x: frame.midX, y: frame.midY), radius: radius, startAngle: 0, endAngle: endAngle, clockwise: false)

        //Use shadow to create a blur effect
        //imageCtx.setShadow(offset: CGSize(width: 0, height: 0), blur: CGFloat(angle / 15), color: UIColor.black.cgColor)

        //define the path
        imageCtx.setLineWidth(CircularSlider.lineWidth)
        imageCtx.drawPath(using: .stroke)

        //save the context content into the image mask
        let mask = UIGraphicsGetCurrentContext()!.makeImage()!
        UIGraphicsEndImageContext()

        /** Clip Context to the mask **/
        ctx.saveGState()
        ctx.clip(to: bounds, mask: mask)

        /** The Gradient **/

        // Setup the gradient
        let startColorComps = UIColor.yellow.cgColor.components!
        let endColorComps = UIColor.red.cgColor.components!
        let components = [
            startColorComps[0], startColorComps[1], startColorComps[2], 1,
            endColorComps[0], endColorComps[1], endColorComps[2], 1
        ]

        let baseSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: baseSpace, colorComponents: components, locations: nil, count: 2)!

        // Gradient direction
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)

        // Draw the gradient
        ctx.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        ctx.restoreGState()

        // Draw a white knob over the circle
        ctx.saveGState()
        ctx.setShadow(offset: .zero, blur: 3, color: UIColor.black.cgColor)
        let centerPoint = CGPoint(x: frame.size.width / 2 - CircularSlider.lineWidth / 2, y: frame.size.height / 2 - CircularSlider.lineWidth / 2)

        // The point position on the circumference
        // Given the angle, get the point position on circumference
        let angleRadian = CGFloat(Measurement(value: Double(-angle), unit: UnitAngle.degrees).converted(to: .radians).value)
        let x = (radius * cos(angleRadian)).rounded() + centerPoint.x
        let y = (radius * sin(angleRadian)).rounded() + centerPoint.y
        let handleCenter = CGPoint(x: x, y: y)
        UIColor.white.set()
        ctx.fillEllipse(in: CGRect(x: handleCenter.x, y: handleCenter.y, width: CircularSlider.lineWidth, height: CircularSlider.lineWidth))
        ctx.restoreGState()
    }

}
