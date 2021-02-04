//
//  SpeedViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class SpeedViewController: BaseViewController, SpeedViewInput, GaugeViewDelegate {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    private enum Constants {
        static let cardSize: CGSize = .init(width: 130, height: 90)
    }
    var output: SpeedViewOutput?
    
    var velocity: Double = 0
    var acceleration: Double = 5

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let speedCardView = InformationRoundedView()
    private let distanceCardView = InformationRoundedView()
    private let odoCardView = InformationRoundedView()
    
    private let gaugeView = GaugeView()

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
      AppDelegate.AppUtility.lockOrientation(.landscapeRight, andRotateTo: .landscapeRight)
    }
        
    override func viewWillDisappear(_ animated : Bool) {
      super.viewWillDisappear(animated)
      AppDelegate.AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }

    // ------------------------------
    // MARK: - SpeedViewInput
    // ------------------------------

    func display(viewAdapter: SpeedViewAdapter) {
        speedCardView.display(type: .avgSpeed(num: 12))
        distanceCardView.display(type: .distance(num: 12))
        odoCardView.display(type: .odo(num: 12))
    }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    func ringStokeColor(gaugeView: GaugeView, value: Double) -> UIColor {
        switch value {
        case 0...51: return .green
        case 52...80: return .orange
        case 81...100: return .red
        default: return .green
        }
    }

    private func setupViews() {
        view.backgroundColor = .black
        
        gaugeView.delegate = self
        gaugeView.value = 81
        
        // Update gauge view
        gaugeView.minValue = 0
        gaugeView.maxValue = 100
        gaugeView.layer.masksToBounds = false

        gaugeView.setNeedsDisplay()
        

        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [speedCardView, distanceCardView, odoCardView, gaugeView].forEach(view.addSubview(_:))
    }

    private func setupConstraints() {
        [speedCardView, distanceCardView, odoCardView].forEach { cardView in
            cardView.snp.makeConstraints {
                $0.left.equalTo(48)
                $0.size.equalTo(Constants.cardSize)
            }
        }
        speedCardView.snp.makeConstraints { $0.top.equalTo(20) }
        distanceCardView.snp.makeConstraints { $0.centerY.equalToSuperview() }
        odoCardView.snp.makeConstraints { $0.bottom.equalTo(-20) }
        gaugeView.snp.makeConstraints {
            $0.size.equalTo(300)
            $0.center.equalToSuperview()
        }
    }
}
