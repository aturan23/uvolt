//
//  LocalLocalizer.swift
//  uvolt
//
//  Created by Turan Assylkhan on 01.02.2021.
//  Copyright © 2021 Turan Assylkhan. All rights reserved.
//

import Foundation

class LocalLocalizer {
    private enum LocalConstants {
        static let localizationFileName = "str-localization-"
    }
    
    static let shared = LocalLocalizer()
    
    var currentLanguage: SupportedLanguage {
        didSet {
            readTranslationsFile()
        }
    }
    
    private let fileManager: FileManager
    
    private var localization: [String: String] = [:]
    
    private var currentLanguageDescription: String {
        return currentLanguage.rawValue
    }
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        currentLanguage = SupportedLanguage.defineCurrentLanguage()
        readTranslationsFile()
    }
    
    private func readTranslationsFile() {
        copyLocalizationsFromBundleToDocuments()
        let path = getPath(for: currentLanguage)
        if fileManager.fileExists(atPath: path) {
            do {
                if let data = fileManager.contents(atPath: path) {
                    let translations = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                    localization = translations ?? [:]
                }
            } catch let error {
                print(error)
                fatalError()
            }
        }
    }
    
    private func copyLocalizationsFromBundleToDocuments() {
        for language in SupportedLanguage.all {
            let data = getFileData(for: language)
            let path = getPath(for: language)
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
        }
    }
    private func getFileData(for language: SupportedLanguage) -> Data {
        guard let bundledTranslationJSON = Bundle.main.path(forResource: getResourceName(for: language), ofType: nil).flatMap({ try? String(contentsOfFile: $0) }),
            let fileData = bundledTranslationJSON.data(using: .utf8) else { fatalError() }
        return fileData
    }
    
    private func getPath(for language: SupportedLanguage) -> String {
        return GlobalConstants.Localization.documentsDirectory
            + "/"
            + getResourceName(for: language)
            + GlobalConstants.Localization.localizationFileExtension
    }
    
    private func getResourceName(for language: SupportedLanguage) -> String {
        return LocalConstants.localizationFileName
            + language.rawValue
    }
}

extension LocalLocalizer: LocalizerType {
    
    func getLocalization(for key: String) -> String {
        let fullKey = addLanguagePostfix(for: key)
        return localization[fullKey] ?? key
    }
    
    func changeLanguage(_ language: SupportedLanguage) {
        currentLanguage = language
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: UvoltNotifications.languageDidChange.name, object: nil)
        }
    }
    
    private func addLanguagePostfix(for key: String) -> String {
        return key + "-" + currentLanguageDescription
    }
}
