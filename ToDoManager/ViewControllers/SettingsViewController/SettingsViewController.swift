//
//  SettingsViewController.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTable: UITableView!
    
    private let menuPoints = SettingPoints.allCases
    private let languages = Languages.allCases
//    private var currentLang = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        settingsTable.dataSource = self
        settingsTable.delegate = self
//        title = "Настройки"
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.systemMint]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.systemMint]

        setupTable()
        updateLanguage()
        subscribeToNotification()

    }
    
    func setupTable() {
        
        let nib = UINib(nibName: String(describing: SettingsCell.self), bundle: nil)
        settingsTable.register(nib, forCellReuseIdentifier: String(describing: SettingsCell.self))
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsCell.self), for: indexPath)
        guard let settingCell = cell as? SettingsCell else { return cell }
        settingCell.nameLabel.text = menuPoints[indexPath.row].localizedValue.localized()
        settingCell.setupCellWith(menuPoints[indexPath.row])
        
//        settingCell.languageIndicator.text = currentLang
        settingCell.languageIndicator.text = UserDefaults.standard.string(forKey: "currentLang")

        
        return settingCell
    }
}
    
    extension SettingsViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            if indexPath.row == 2 {
                
                let languageAlert = UIAlertController(title: AppLocalizationKeys.chooseLanguage.localized(), message: nil, preferredStyle: .actionSheet)
                for lang in languages {
                    let action = UIAlertAction(title: lang.rawValue, style: .default) { _ in
                        print("Установлен язык: \(lang.rawValue)")
                        Bundle.setLanguage(lang: lang.rawValue)
//                        self.currentLang = lang.rawValue
                        UserDefaults.standard.set(lang.rawValue, forKey: "currentLang")
//                        BarController.languageAbb = lang.rawValue
                    }
                    languageAlert.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel)
                languageAlert.addAction(cancelAction)
                self.present(languageAlert, animated: true)
            }
        }
}

extension SettingsViewController: LanguageUpdatable {
    
    @objc func updateLanguage() {
        
        self.title = AppLocalizationKeys.title.localized()
        settingsTable.reloadData()
    }
    
    func subscribeToNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChange"), object: nil)
    }
}
