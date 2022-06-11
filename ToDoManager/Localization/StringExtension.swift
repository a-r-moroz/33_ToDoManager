//
//  StringExtension.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localization", bundle: Bundle.localizedBundle(), value: self, comment: self)
    }
}


