//
//  OPLGaugeView.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

class GaugeLayer: CAShapeLayer {
    
    internal var disableSpringAnimation: Bool = true
    
    override func action(forKey event: String) -> CAAction? {
        if event == "transform" && !disableSpringAnimation {
            let springAnimation = CASpringAnimation(keyPath: event)
            springAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            springAnimation.initialVelocity = 0.8
            springAnimation.damping = 1
            return springAnimation
        }
        return super.action(forKey: event)
    }
}

class OPLGaugeView: UIView {
    
    private lazy var gauge: GaugeLayer = {
        let _gauge = GaugeLayer()
        _gauge.drawsAsynchronously = true
        _gauge.disableSpringAnimation = true
        return _gauge
    }()
    var enableSpring: Bool {
        set { gauge.disableSpringAnimation = newValue }
        get { return gauge.disableSpringAnimation }
    }
    var displayMarkers: Bool = true {
        didSet { setNeedsDisplay() }
    }
    var gaugeColor: UIColor = UIColor.orange {
        didSet {
            gauge.fillColor = gaugeColor.cgColor
            setNeedsDisplay()
        }
    }
    var markers: Int = 5 {
        didSet { setNeedsDisplay() }
    }
    var minSpeed: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }
    var maxSpeed: CGFloat = 25 {
        didSet { setNeedsDisplay() }
    }
    var startingSpeed: CGFloat = 0 {
        didSet {
            if startingSpeed > maxSpeed {
                startingSpeed = maxSpeed
            }
            if startingSpeed < minSpeed {
                startingSpeed = minSpeed
            }
            setNeedsDisplay()
        }
    }
    private let lineWidth: CGFloat = 6
    
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2
        let startAngle: CGFloat = 0.75 * CGFloat(Double.pi)
        let endAngle: CGFloat = 0.25 * CGFloat(Double.pi)
        let outlinePath = UIBezierPath(arcCenter: center, radius: radius - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true)
        outlinePath.lineWidth = lineWidth
        gaugeColor.setStroke()
        outlinePath.stroke()
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        gaugeColor.setFill()
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerMark: CGFloat = angleDifference / CGFloat(markers)
        let markerWidth: CGFloat = lineWidth - 1
        let markerSize: CGFloat = markerWidth * 2
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize).integral)
        context.translateBy(x: rect.width / 2, y: rect.height / 2)
        for i in 0...markers {
            context.saveGState()
            let angle = arcLengthPerMark * CGFloat(i) + startAngle - .pi / 2
            context.rotate(by: angle)
            context.translateBy(x: 0, y: rect.height / 2 - markerSize)
            if displayMarkers {
                markerPath.fill()
            }
            context.rotate(by: CGFloat(Double.pi))
            context.restoreGState()
        }
        context.restoreGState()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        gauge.fillColor = gaugeColor.cgColor
        layer.addSublayer(gauge)
        let anchorPoint = CGPoint(x: 0.5, y: 1.0)
        let newPoint = CGPoint(x: gauge.bounds.size.width * anchorPoint.x, y: gauge.bounds.size.height * anchorPoint.y)
        let oldPoint = CGPoint(x: gauge.bounds.size.width * gauge.anchorPoint.x, y: gauge.bounds.size.height * gauge.anchorPoint.y)
        var position = gauge.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        gauge.position = position
        gauge.anchorPoint = anchorPoint
        
        rotateGauge(newSpeed: startingSpeed)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let viewWidth = frame.width
        let halfViewWidth = viewWidth / 2
        let viewHeight = frame.height
        let gaugeYPos: CGFloat = viewHeight * 0.05
        let gaugeHeight: CGFloat = viewHeight * 0.45
        let gaugeWidth: CGFloat = gaugeHeight * 0.16
        let gaugeFrame = CGRect(x: halfViewWidth - (gaugeWidth / 2), y: gaugeYPos, width: gaugeWidth, height: gaugeHeight).integral
        gauge.bounds.size = gaugeFrame.size
        gauge.position.x = gaugeFrame.origin.x + (gaugeFrame.width / 2)
        gauge.position.y = gaugeFrame.origin.y + gaugeFrame.height
        let gaugePath = UIBezierPath()
        gaugePath.move(to: CGPoint(x: gaugeWidth / 2, y: 0))
        gaugePath.addLine(to: CGPoint(x: gaugeWidth, y: gaugeHeight))
        gaugePath.addLine(to: CGPoint(x: 0, y: gaugeHeight))
        gaugePath.close()
        gauge.path = gaugePath.cgPath
    }
    
    func rotateGauge(newSpeed: CGFloat) {
        var speed = newSpeed
        if speed > maxSpeed {
            speed = maxSpeed
        }
        if speed < minSpeed {
            speed = minSpeed
        }
        let fractalSpeed = (speed - minSpeed) / (maxSpeed - minSpeed)
        let newAngle = 0.75 * CGFloat(Double.pi) * (2 * fractalSpeed - 1)
        gauge.transform = CATransform3DMakeRotation(newAngle, 0, 0, 1)
    }
}

fileprivate extension String {
    func width(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: CGFloat(220))
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
