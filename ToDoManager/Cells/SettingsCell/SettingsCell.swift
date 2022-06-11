//
//  SettingsCell.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import UIKit

class SettingsCell: UITableViewCell {

    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageIndicator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.editingAccessoryType = .disclosureIndicator
//        settingImage.image = UIImage(systemName: "bell.square.fill")
        self.accessoryType = .disclosureIndicator

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupCellWith(_ type: SettingPoints) {
        settingImage.image = type.settingImage
        languageIndicator.isHidden = type.settingLanguageLabelIndicator
    }
    
}
