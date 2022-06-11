//
//  BarManager.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import UIKit

class BarController: UITabBarController {
        
    static var languageAbb: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupControllers()
    }
    
    private func setupControllers() {
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        
        let tasksVC = UINavigationController(rootViewController: TasksViewController())
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        
        tasksVC.navigationBar.tintColor = UIColor.systemMint
        settingsVC.navigationBar.tintColor = UIColor.systemMint
        
        tasksVC.tabBarItem = UITabBarItem(
            title: AppLocalizationKeys.tasksTitle.localized(),
            image: UIImage(systemName: "checklist")?.withConfiguration(iconConfig),
            tag: 0)
        settingsVC.tabBarItem = UITabBarItem(
            title: AppLocalizationKeys.title.localized(),
            image: UIImage(systemName: "gearshape.2")?.withConfiguration(iconConfig),
            tag: 0)
        
        self.tabBar.tintColor = .systemMint
        self.viewControllers = [tasksVC, settingsVC]
    }
}
