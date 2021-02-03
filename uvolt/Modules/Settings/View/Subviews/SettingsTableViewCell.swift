//
//  SettingsTableViewCell.swift
//  uvolt
//
//  Created by Turan Assylkhan on 03.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import UIKit

enum SettingFrameType {
    case name
    case measurment
    case distance
    case odometer
    case calory
    case cost
    case log
    case firmware
    case language
}

enum SettingMeasurmentType: String {
    case kilometer = "Kilometers"
    case meter = "Meters"
    case inch = "Inch"
    var title: String {
        return self.rawValue
    }
}

class SettingsTableViewCell: UITableViewCell {

    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private enum Constants {
        static let titleColor = UIColor(red: 0.567, green: 0.567, blue: 0.567, alpha: 1)
        static let buttonTitleColor = UIColor(red: 0.623, green: 0.637, blue: 0.679, alpha: 1)
        static let buttonBackColor = UIColor(red: 0.156, green: 0.163, blue: 0.188, alpha: 1)
        static let measurmentComponents: [SettingMeasurmentType] = [.kilometer,
                                                                    .meter,
                                                                    .inch]
        static let languages: [SupportedLanguage] = SupportedLanguage.all
    }

    private var frameType: SettingFrameType = .name

    // ------------------------------
    // MARK: - UI components
    // ------------------------------
    private var titleLabel = LabelFactory().make(withStyle: .paragraphSecondary, textColor: Constants.titleColor)

    private var inputField: UITextField = {
        let view = UITextField()
        view.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        view.textColor = .white
        view.text = "My Bike"
        view.textAlignment = .right
        view.isUserInteractionEnabled = false

        return view
    }()

    private var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("EDIT".localized().uppercased(), for: .normal)
        button.setTitleColor(Constants.buttonTitleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 14
        button.backgroundColor = Constants.buttonBackColor

        return button
    }()

    private lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self

        return view
    }()
    // ------------------------------
    // MARK: - Initializate
    // ------------------------------
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // ------------------------------
    // MARK: - Setups
    // ------------------------------
    private func setupViews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none

        titleLabel.numberOfLines = 2
        editButton.addTarget(self, action: #selector(editButtonAction(_:)), for: .touchUpInside)

        [editButton, titleLabel, inputField].forEach(contentView.addSubview(_:))

        editButton.snp.makeConstraints({
            $0.top.equalTo(16)
            $0.bottom.right.equalTo(-16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(28)
            $0.width.equalTo(78)
        })

        titleLabel.snp.makeConstraints({
            $0.left.equalTo(16)
            $0.centerY.equalToSuperview()
        })

        inputField.snp.makeConstraints({
            $0.left.equalTo(titleLabel.snp.right).offset(8)
            $0.right.equalTo(editButton.snp.left).offset(-8)
            $0.width.greaterThanOrEqualTo(85)
            $0.centerY.equalToSuperview()
        })
    }

    func display(by type: SettingFrameType) {
        self.frameType = type
        switch type {
        case .name:
            titleLabel.text = "Bike Name"
            inputField.keyboardType = .default
            inputField.text = "My Bike"
            editButton.setTitle("EDIT".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: true)
        case .measurment:
            titleLabel.text = "Unit  of measurment"
            inputField.inputView = pickerView
            inputField.text = "Kilometers"
            editButton.setTitle("EDIT".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: true)
        case .distance:
            titleLabel.text = "Trip Distance"
            inputField.keyboardType = .decimalPad
            inputField.text = "1.0"
            editButton.setTitle("RESET".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: true)
        case .odometer:
            titleLabel.text = "Odometer"
            inputField.keyboardType = .decimalPad
            inputField.text = "58.9"
            editButton.setTitle("UPLOAD".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: false)
        case .calory:
            titleLabel.text = "Calories Burned"
            inputField.keyboardType = .decimalPad
            inputField.text = "35.0"
            editButton.setTitle("RESET".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: true)
        case .cost:
            titleLabel.text = "Cost Per Kwh"
            inputField.keyboardType = .default
            inputField.text = "--"
            editButton.setTitle("RESET".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: true)
        case .log:
            titleLabel.text = "Log Upload"
            inputField.text = ""
            editButton.setTitle("UPLOAD".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: false)
        case .firmware:
            titleLabel.text = "Firmware Version"
            inputField.text = "EPACC--,--"
            editButton.setTitle("UPDATE".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: true)
        case .language:
            titleLabel.text = "Language"
            inputField.inputView = pickerView
            inputField.text = "English"
            editButton.setTitle("EDIT".localized().uppercased(), for: .normal)
            enableEditButton(isEnabled: true)
        }
    }

    private func enableEditButton(isEnabled: Bool) {
        editButton.isEnabled = isEnabled
        editButton.setTitleColor(isEnabled ? Constants.buttonTitleColor : .black,
                                 for: .normal)
    }

    private func editAction() {
        self.endEditing(true)
        inputField.isUserInteractionEnabled.toggle()
        let buttonTitle = inputField.isUserInteractionEnabled ? "SAVE" : "EDIT"
        editButton.setTitle(buttonTitle.localized().uppercased(), for: .normal)
        inputField.becomeFirstResponder()
    }

    private func resetAction() {

    }

    private func updateAction() {

    }

    private func uploadAction() {

    }

    @objc
    private func editButtonAction(_ sender: UIButton) {
        switch frameType {
        case .name, .measurment, .language:
            editAction()
        case .distance, .calory, .cost:
            resetAction()
        case .odometer, .log:
            uploadAction()
        case .firmware:
            updateAction()
        }
    }
}

extension SettingsTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        frameType == .measurment ?
            Constants.measurmentComponents.count :
            Constants.languages.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        frameType == .measurment ?
            Constants.measurmentComponents[row].title:
            Constants.languages[row].localizedTitle
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputField.text = Constants.measurmentComponents[row].title
    }
}
