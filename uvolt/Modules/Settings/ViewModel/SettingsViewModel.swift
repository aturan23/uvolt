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
        settings.setValue(adapter.toJSON(), forKey: "settingsAdapter")
        
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
                if let jsonString = data.value(forKey: "settingsAdapter") as? String {
                    let jsonData = Data(jsonString.utf8)
                    do {
                        let items = try JSONDecoder().decode([SettingItem].self, from: jsonData)
                        return SettingsViewAdapter(items: items)
                    }
                }
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
