//
//  Bundle+Extension.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import Foundation

extension Bundle {
    
    private static var bundle: Bundle!

    static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let path = Bundle.main.path(forResource: UserDefaults.standard.value(forKey: "language") as? String ?? Languages.russian.rawValue, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle
    }

    static func setLanguage(lang: String) {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
        UserDefaults.standard.set(lang, forKey: "language")
        NotificationCenter.default.post(name: Notification.Name("LanguageChange"), object: nil)
    }
}
