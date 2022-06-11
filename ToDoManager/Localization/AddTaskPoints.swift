//
//  AddTaskPoints.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import Foundation

enum AddTaskPoints: String, CaseIterable {
    
    case header
    case body
    case add

    
    var localizedValue: String {
        switch self {
        case .header:
            return AppLocalizationKeys.header
        case .body:
            return AppLocalizationKeys.body
        case .add:
            return AppLocalizationKeys.add
        }
    }
}

enum tasksPoints: String, CaseIterable {
    
    case tasksTitle
    
    var localizedValue: String {
        switch self {
        case .tasksTitle:
            return AppLocalizationKeys.tasksTitle
        }
    }
}

enum editPoints: String, CaseIterable {
    
    case editHeader
    case editBody
    case editDate
    
    var localizedValue: String {
        switch self {
        case .editHeader:
            return AppLocalizationKeys.editHeader
        case .editBody:
            return AppLocalizationKeys.editBody
        case .editDate:
            return AppLocalizationKeys.editDate
        }
    }
}
