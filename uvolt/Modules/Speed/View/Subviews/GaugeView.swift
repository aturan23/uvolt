//
//  GaugeView.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

protocol GaugeViewDelegate: class {
    /// Return ring stroke color from the specified value.
    func ringStokeColor(gaugeView: GaugeView, value: Double) -> UIColor
}

class GaugeView: UIView {
    
    // MARK: PROPERTIES
    
    private let labelFactory = LabelFactory()
    
    /// Current value.
    var value: Double = 0 {
        didSet {
            value = max(min(value, maxValue), minValue)
            
            // Set text for value label
            valueLabel.text = String(format: "%.0f", value)
            
            // Trigger the stoke animation of ring layer
            strokeGauge()
        }
    }
    
    /// Minimum value.
    var minValue: Double = 0
    
    /// Maximum value.
    var maxValue: Double = 120
    
    /// Limit value.
    var limitValue: Double = 50
    
    /// The thickness of the ring.
    private var ringThickness: CGFloat = 30
    
    /// A boolean indicates whether to show limit dot.
    var showLimitDot: Bool = true
    
    /// The radius of limit dot.
    var limitDotRadius: Double = 2
    
    /// The color of limit dot.
    var limitDotColor: UIColor = .red
    
    /// Text color of value label.
    var valueTextColor: UIColor = .red
    
    /// The receiver of all gauge view delegate callbacks.
    weak var delegate: GaugeViewDelegate? = nil
    
    var startAngle: CGFloat = .pi * 3/4
    var endAngle: CGFloat = .pi/4 + .pi * 2
    private let points = 24
    
    var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = CAShapeLayerLineCap.butt
        layer.lineJoin = CAShapeLayerLineJoin.bevel
        layer.strokeEnd = 0
        return layer
    }()
    var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = CAShapeLayerLineCap.butt
        layer.lineJoin = CAShapeLayerLineJoin.bevel
        layer.strokeEnd = 0
        return layer
    }()
    
    private lazy var valueLabel = labelFactory.make(
        withStyle: .headingH1,
        textAlignment: .center)
    
    lazy var unitOfMeasurementLabel = labelFactory.make(
        withStyle: .paragraphBody,
        text: "SPEED".localized(),
        textColor: .white,
        textAlignment: .center)
    
    // MARK: DRAWING
    
    override open func draw(_ rect: CGRect) {
        let smallThickness: CGFloat = 7
        // Progress Layer
        addLayer(progressLayer)
        drawBorderedLayer(&progressLayer, thickness: ringThickness)
        
        addLayer(borderLayer)
        drawBorderedLayer(&borderLayer, thickness: smallThickness)
        addInnerIndicators(thickness: smallThickness)
        
        
        setupValueAndMeasurementViews()
        
//        let context = UIGraphicsGetCurrentContext()
//        let lineWidth: CGFloat = 6
//        let markers = 24
//        let gaugeColor = UIColor.white
//        let radius = min(bounds.width, bounds.height) / 2
//        let startAngle: CGFloat = 0.75 * CGFloat(Double.pi)
//        let endAngle: CGFloat = 0.25 * CGFloat(Double.pi)
//        let outlinePath = UIBezierPath(arcCenter: center, radius: radius - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        outlinePath.lineWidth = lineWidth
//        gaugeColor.setStroke()
//        outlinePath.stroke()
//        context?.saveGState()
//        gaugeColor.setFill()
//        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
//        let arcLengthPerMark: CGFloat = angleDifference / CGFloat(markers)
//        let markerWidth: CGFloat = lineWidth - 1
//        let markerSize: CGFloat = 13
//        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize).integral)
//        context?.translateBy(x: rect.width / 2, y: rect.height / 2)
//        for i in 0...markers {
//            context?.saveGState()
//            let angle = arcLengthPerMark * CGFloat(i) + startAngle - .pi / 2
//            context?.rotate(by: angle)
//            context?.translateBy(x: 0, y: rect.height / 2 - markerSize)
//            markerPath.fill()
//            context?.rotate(by: CGFloat(Double.pi))
//            context?.restoreGState()
//        }
    }
    
    func strokeGauge() {
        // Set progress for ring layer
        let progress = maxValue != 0 ? (value - minValue)/(maxValue - minValue) : 0
        progressLayer.strokeEnd = CGFloat(progress)
        borderLayer.strokeEnd = CGFloat(maxValue)
        
        // Set ring stroke color
        var ringColor = UIColor(red: 76.0/255, green: 217.0/255, blue: 100.0/255, alpha: 1)
        if let delegate = delegate {
            ringColor = delegate.ringStokeColor(gaugeView: self, value: value)
        }
        progressLayer.strokeColor = ringColor.cgColor
        borderLayer.strokeColor = UIColor.white.cgColor
    }
    
    private func setupValueAndMeasurementViews() {
        // Value Label
        if valueLabel.superview == nil {
            addSubview(valueLabel)
        }
        valueLabel.text = String(format: "%.0f", value)
        valueLabel.textColor = valueTextColor
        let insetX = ringThickness
        valueLabel.frame = progressLayer.frame.insetBy(dx: CGFloat(insetX), dy: CGFloat(insetX))
        valueLabel.frame = valueLabel.frame.offsetBy(dx: 0, dy: 0)
        
        // Unit Of Measurement Label
        if unitOfMeasurementLabel.superview == nil {
            addSubview(unitOfMeasurementLabel)
        }
        unitOfMeasurementLabel.frame = CGRect(x: valueLabel.frame.origin.x,
                                              y: valueLabel.frame.maxY - 10,
                                              width: valueLabel.frame.width,
                                              height: 20)
    }
    
    private func drawBorderedLayer(_ subLayer: inout CAShapeLayer, thickness: CGFloat) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = (min(bounds.width, bounds.height))/2 - thickness/2
        
        subLayer.frame = CGRect(x: center.x - radius - CGFloat(thickness)/2,
                                y: center.y - radius - CGFloat(thickness)/2,
                                width: (radius + CGFloat(thickness)/2) * 2,
                                height: (radius + CGFloat(thickness)/2) * 2)
        subLayer.bounds = subLayer.frame
        let smoothedPath = UIBezierPath(arcCenter: subLayer.position,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
        subLayer.path = smoothedPath.cgPath
        subLayer.lineWidth = CGFloat(thickness)
    }
    
    private func addInnerIndicators(thickness: CGFloat) {
        let radius = min(bounds.width, bounds.height) / 2 - thickness
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.position = CGPoint(x: bounds.midX - center.x, y: bounds.midY - center.y )
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.white.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 10
        let one : NSNumber = 3
        let two : NSNumber = 11
        shapeLayer.lineDashPattern = [one, two]
        shapeLayer.lineCap = CAShapeLayerLineCap.butt
        
        layer.addSublayer(shapeLayer)
    }
    
    private func addLayer(_ subLayer: CAShapeLayer) {
        if subLayer.superlayer == nil {
            layer.addSublayer(subLayer)
        }
    }
}
