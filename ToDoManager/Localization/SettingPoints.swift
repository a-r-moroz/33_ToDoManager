//
//  SettingPoints.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import Foundation
import UIKit

enum SettingPoints: String, CaseIterable {
    
    case profile
    case notifications
    case language
    
    var localizedValue: String {
        switch self {
        case .profile:
            return AppLocalizationKeys.profile
        case .notifications:
            return AppLocalizationKeys.notifications
        case .language:
            return AppLocalizationKeys.language
        }
    }
    
    var settingImage: UIImage? {
        switch self {
        case .profile:
            return UIImage(systemName: "person.crop.square.fill")
        case .notifications:
            return UIImage(systemName: "bell.square.fill")
        case .language:
            return UIImage(systemName: "a.square.fill")
        }
    }
    
    var settingLanguageLabelIndicator: Bool {
        switch self {
        case .profile:
            return true
        case .notifications:
            return true
        case .language:
            return false
        }
    }
}

enum ChooseLanguagePoints: String, CaseIterable {
    
    case chooseLanguage

    var localizedValue: String {
        switch self {
        case .chooseLanguage:
            return AppLocalizationKeys.chooseLanguage
        }
    }
}
