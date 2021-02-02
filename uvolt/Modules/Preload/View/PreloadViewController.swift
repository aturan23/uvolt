//
//  PreloadViewController.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//

import UIKit

class PreloadViewController: BaseViewController, PreloadViewInput {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------

    private enum Constants {
        static let imageSize: CGSize = .init(width: 240, height: 128)
        static let progressHeight: CGFloat = 10
    }
    var output: PreloadViewOutput?

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.tintColor = Color.red
        progressView.layer.cornerRadius = (Constants.progressHeight / 2) - 1
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.white.cgColor
        return progressView
    }()

    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.didLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // ------------------------------
    // MARK: - PreloadViewInput
    // ------------------------------

    func display(viewAdapter: PreloadViewAdapter) { }

    // ------------------------------
    // MARK: - Private methods
    // ------------------------------

    private func setupViews() {
        view.backgroundColor = .black

        animateProgress() { [weak self] in
            self?.output?.showConnectPage()
        }
        setupViewsHierarchy()
        setupConstraints()
    }

    private func setupViewsHierarchy() {
        [imageView, progressView].forEach(view.addSubview(_:))
    }
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
        }
        progressView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Constants.progressHeight)
            $0.width.equalTo(Constants.imageSize.width)
        }
    }
    
    private func animateProgress(completion: @escaping () -> ()) {
        UIView.animate(withDuration: 5, animations: { [weak self] in
            self?.progressView.setProgress(1, animated: true)
        }, completion: { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                completion()
            }
        })
    }
}
