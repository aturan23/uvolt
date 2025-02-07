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
    
    /// The thickness of the ring.
    private var ringThickness: CGFloat = 30
    
    /// Text color of value label.
    var valueTextColor: UIColor = .red
    
    /// The receiver of all gauge view delegate callbacks.
    weak var delegate: GaugeViewDelegate? = nil
    
    private var startAngle: CGFloat = .pi * 3/4
    private var endAngle: CGFloat = .pi/4 + .pi * 2
    private let points = 24
    
    private lazy var ellipseLayer = buildDefaultLayer()
    
    private lazy var progressLayer = buildDefaultLayer()
    private lazy var smallProgressLayer = buildDefaultLayer()
    
    private lazy var borderLayer = buildDefaultLayer()
    private lazy var smallBorderLayer = buildDefaultLayer()
    
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
        let smallAndRingThickness = smallThickness + ringThickness
        let ellipseRadiusDiff: CGFloat = -80
        
        addLayer(ellipseLayer)
        drawBorderedLayer(&ellipseLayer, thickness: ringThickness, radiusDiff: ellipseRadiusDiff, start: startAngle + .pi/20)
        addSmallInnerIndicators(thickness: ellipseRadiusDiff / 2)
        
        addLayer(progressLayer)
        drawBorderedLayer(&progressLayer, thickness: ringThickness, radiusDiff: smallAndRingThickness)
        
        addLayer(borderLayer)
        drawBorderedLayer(&borderLayer, thickness: smallThickness, radiusDiff: smallThickness)
        
        addLayer(smallBorderLayer)
        drawBorderedLayer(&smallBorderLayer, thickness: smallThickness, radiusDiff: smallAndRingThickness * 2)
        
        addLayer(smallProgressLayer)
        drawBorderedLayer(&smallProgressLayer, thickness: ringThickness / 2, radiusDiff: (smallAndRingThickness + ringThickness / 3) * 2)
        
        addInnerIndicators(thickness: smallThickness)
        setupValueAndMeasurementViews()
    }
    
    func strokeGauge() {
        // Set progress for ring layer
        let progress = maxValue != 0 ? (value - minValue)/(maxValue - minValue) : 0
        ellipseLayer.strokeEnd = CGFloat((30 - minValue)/(maxValue - minValue))
        progressLayer.strokeEnd = CGFloat(progress)
        smallProgressLayer.strokeEnd = CGFloat(progress)
        
        borderLayer.strokeEnd = CGFloat(maxValue)
        smallBorderLayer.strokeEnd = CGFloat(maxValue)
        
        // Set ring stroke color
        var ringColor = UIColor(red: 76.0/255, green: 217.0/255, blue: 100.0/255, alpha: 1)
        if let delegate = delegate {
            ringColor = delegate.ringStokeColor(gaugeView: self, value: value)
        }
        
        ellipseLayer.strokeColor = UIColor.white.cgColor
        
        progressLayer.strokeColor = ringColor.cgColor
        smallProgressLayer.strokeColor = ringColor.withAlphaComponent(0.3).cgColor
        
        borderLayer.strokeColor = UIColor.white.cgColor
        smallBorderLayer.strokeColor = Color.textHighContrast.cgColor
    }
    
    private func drawBorderedLayer(_ subLayer: inout CAShapeLayer, thickness: CGFloat, radiusDiff: CGFloat = 0, start: CGFloat = 0) {
        let startAngle = start == 0 ? self.startAngle : start
        let center = CGPoint(x: bounds.width/2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width, bounds.height) / 2 - radiusDiff / 2
        
        subLayer.frame = CGRect(x: center.x - radius - thickness / 2,
                                y: center.y - radius - thickness / 2,
                                width: (radius + thickness / 2 ) * 2,
                                height: (radius + thickness / 2) * 2)
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
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - thickness
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
    
    private func addSmallInnerIndicators(thickness: CGFloat) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2 - thickness
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.position = CGPoint(x: bounds.midX - center.x, y: bounds.midY - center.y )
        //change the fill color
        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.black.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3
        let one : NSNumber = 10
        let two : NSNumber = 7
        shapeLayer.lineDashPattern = [one, two].reversed()
        shapeLayer.lineCap = CAShapeLayerLineCap.butt
        shapeLayer.strokeEnd = CGFloat((30 - minValue)/(maxValue - minValue))
        
        layer.addSublayer(shapeLayer)
    }
    
    private func addLayer(_ subLayer: CAShapeLayer) {
        if subLayer.superlayer == nil {
            layer.addSublayer(subLayer)
        }
    }
    
    private func addView(_ subView: UIView) {
        if subView.superview == nil {
            addSubview(subView)
        }
    }
    
    private func setupValueAndMeasurementViews() {
        // Value Label
        addView(valueLabel)
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.5
        valueLabel.text = String(format: "%.0f", value)
        valueLabel.textColor = valueTextColor
        valueLabel.snp.makeConstraints { $0.center.equalToSuperview() }
        
        // Unit Of Measurement Label
        addView(unitOfMeasurementLabel)
        unitOfMeasurementLabel.frame = CGRect(x: valueLabel.frame.origin.x,
                                              y: valueLabel.frame.maxY - 50,
                                              width: valueLabel.frame.width,
                                              height: 20)
        let gearButtonView = buildCircleView(text: "1", imaged: false, textColor: .white, size: 50)
        addView(gearButtonView)
        gearButtonView.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }
    }
    
    private func buildCircleView(
        text: String? = nil,
        imaged: Bool = false,
        textColor: UIColor,
        size: CGFloat = 36) -> UIView {
        let containerView = UIView()
        let circleView = UIView(frame: .init(x: 0, y: 0, width: size, height: size))
        circleView.layer.cornerRadius = size / 2
        circleView.layer.borderWidth = 2
        circleView.layer.borderColor = UIColor.white.cgColor
        circleView.backgroundColor = Color.grayBackground
        
        if let text = text {
            let label = labelFactory.make(withStyle: .headingH2,
                                          text: text,
                                          textColor: textColor,
                                          textAlignment: .center)
            circleView.addSubview(label)
            label.snp.makeConstraints { $0.center.equalToSuperview() }
        }
        if imaged {
            let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 8, height: 16))
            imageView.image = UIImage(named: "energy")
            circleView.addSubview(imageView)
            imageView.snp.makeConstraints { $0.center.equalToSuperview() }
        }
        containerView.addSubview(circleView)
        return containerView
    }
    
    private func buildDefaultLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.contentsScale = UIScreen.main.scale
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = CAShapeLayerLineCap.butt
        layer.lineJoin = CAShapeLayerLineJoin.bevel
        layer.strokeEnd = 0
        return layer
    }
}
