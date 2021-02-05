//
//  SettingsViewModel.swift
//  uvolt
//
//  Created by Turan Assylkhan on 02/02/2021.
//  Copyright © 2021 Assylkhan Turan. All rights reserved.
//
import UIKit
import CoreData

class SettingsViewModel: SettingsViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: SettingsViewInput?
    var router: SettingsRouterInput?
    weak var moduleOutput: SettingsModuleOutput?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var context = appDelegate.persistentContainer.viewContext


    // ------------------------------
    // MARK: - SettingsViewOutput methods
    // ------------------------------
    
    func didLoad() {
        view?.display(viewAdapter: getAdapter())
    }
    
    func setItemValue(by type: SettingFrameType, value: String?) {
        var editedAdapter = getAdapter()
        for (index, adapterItem) in editedAdapter.items.enumerated() {
            if type == adapterItem.type {
                editedAdapter.items[index].value = value
            }
        }
        
        setToCore(adapter: editedAdapter)
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    private func getResetAdapter() -> SettingsViewAdapter {
        let frameTypeList: [SettingFrameType] = [.name,
                                                 .measurment,
                                                 .distance,
                                                 .odometer,
                                                 .calory,
                                                 .cost,
                                                 .log,
                                                 .firmware,
                                                 .language]
        
        var items: [SettingItem] = []
        frameTypeList.forEach({ items.append(SettingItem(type: $0))})
        
        return SettingsViewAdapter(items: items)
    }
    
    private func setToCore(adapter: SettingsViewAdapter) {
        let entity = NSEntityDescription.entity(forEntityName: "Settings", in: context)
        let settings = NSManagedObject(entity: entity!, insertInto: context)

        adapter.items.forEach { (item) in
            switch item.type {
            case .name:
                settings.setValue(item.value as? String, forKey: "bikeName")
            case .measurment:
                settings.setValue(item.value as? String, forKey: "measurment")
            case .distance:
                settings.setValue(item.value as? Double, forKey: "distance")
            case .odometer:
                settings.setValue(item.value as? Double, forKey: "odometer")
            case .calory:
                settings.setValue(item.value as? Double, forKey: "calory")
            case .cost:
                settings.setValue(item.value as? Double, forKey: "cost")
            case .log:
                settings.setValue(item.value as? String, forKey: "log")
            case .firmware:
                settings.setValue(item.value as? String, forKey: "firmware")
            case .language:
                settings.setValue(item.value as? String, forKey: "language")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }

    }
    
    private func getAdapter() -> SettingsViewAdapter {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Settings")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let bikeName = data.value(forKey: "bikeName") as? String
                let measurment = data.value(forKey: "measurment") as? String
                let distance = data.value(forKey: "distance") as? Double
                let odometer = data.value(forKey: "odometer") as? Double
                let calory = data.value(forKey: "calory") as? Double
                let cost = data.value(forKey: "cost") as? Double
                let log = data.value(forKey: "log") as? String
                let firmware = data.value(forKey: "firmware") as? String
                let language = data.value(forKey: "language") as? String
                
                var items: [SettingItem] = []
                items.append(SettingItem(type: .name, value: bikeName))
                items.append(SettingItem(type: .measurment, value: measurment))
                items.append(SettingItem(type: .distance, value: distance))
                items.append(SettingItem(type: .odometer, value: odometer))
                items.append(SettingItem(type: .calory, value: calory))
                items.append(SettingItem(type: .cost, value: cost))
                items.append(SettingItem(type: .log, value: log))
                items.append(SettingItem(type: .firmware, value: firmware))
                items.append(SettingItem(type: .language, value: language))
                
                return SettingsViewAdapter(items: items)
            }
        } catch {
            print("Failed")
        }

        return getResetAdapter()
    }
}

// ------------------------------
// MARK: - SettingsModuleInput methods
// ------------------------------

extension SettingsViewModel: SettingsModuleInput {
    func configure(data: SettingsConfigData) { }
}
