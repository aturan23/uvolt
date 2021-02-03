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
    
    var startAngle: Double = .pi * 3/4
    var endAngle: Double = .pi/4 + .pi * 2
    
    lazy var progressLayer: CAShapeLayer = {
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
        
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        var radius: CGFloat = (min(bounds.width, bounds.height))/2 - ringThickness/2
        
        // Progress Layer
        if progressLayer.superlayer == nil {
            layer.addSublayer(progressLayer)
        }
        progressLayer.frame = CGRect(x: center.x - radius - CGFloat(ringThickness)/2,
                                     y: center.y - radius - CGFloat(ringThickness)/2,
                                     width: (radius + CGFloat(ringThickness)/2) * 2,
                                     height: (radius + CGFloat(ringThickness)/2) * 2)
        progressLayer.bounds = progressLayer.frame
        let smoothedPath = UIBezierPath(arcCenter: progressLayer.position,
                                        radius: radius,
                                        startAngle: CGFloat(startAngle),
                                        endAngle: CGFloat(endAngle),
                                        clockwise: true)
        progressLayer.path = smoothedPath.cgPath
        progressLayer.lineWidth = CGFloat(ringThickness)
        
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
        
        let context = UIGraphicsGetCurrentContext()
        let lineWidth: CGFloat = 6
        let markers = 24
        let gaugeColor = UIColor.orange
        radius = min(bounds.width, bounds.height) / 2
        let startAngle: CGFloat = 0.75 * CGFloat(Double.pi)
        let endAngle: CGFloat = 0.25 * CGFloat(Double.pi)
        let outlinePath = UIBezierPath(arcCenter: center, radius: radius - (lineWidth / 2), startAngle: startAngle, endAngle: endAngle, clockwise: true)
        outlinePath.lineWidth = lineWidth
        gaugeColor.setStroke()
        outlinePath.stroke()
        context?.saveGState()
        gaugeColor.setFill()
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        let arcLengthPerMark: CGFloat = angleDifference / CGFloat(markers)
        let markerWidth: CGFloat = lineWidth - 1
        let markerSize: CGFloat = 13
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth / 2, y: 0, width: markerWidth, height: markerSize).integral)
        context?.translateBy(x: rect.width / 2, y: rect.height / 2)
        for i in 0...markers {
            context?.saveGState()
            let angle = arcLengthPerMark * CGFloat(i) + startAngle - .pi / 2
            context?.rotate(by: angle)
            context?.translateBy(x: 0, y: rect.height / 2 - markerSize)
            markerPath.fill()
            context?.rotate(by: CGFloat(Double.pi))
            context?.restoreGState()
        }
    }
    
    func strokeGauge() {
        // Set progress for ring layer
        let progress = maxValue != 0 ? (value - minValue)/(maxValue - minValue) : 0
        progressLayer.strokeEnd = CGFloat(progress)

        // Set ring stroke color
        var ringColor = UIColor(red: 76.0/255, green: 217.0/255, blue: 100.0/255, alpha: 1)
        if let delegate = delegate {
            ringColor = delegate.ringStokeColor(gaugeView: self, value: value)
        }
        progressLayer.strokeColor = ringColor.cgColor
    }
}
