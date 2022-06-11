//
//  TaskViewController.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 10.06.22.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var headerField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    @IBOutlet weak var dateField: UITextField!
    
    var task = Task()
    var picker = UIDatePicker()
    var selectedDate: Date?
    var saveTask: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLanguage()
        
        headerField.text = task.header
        bodyField.text = task.body
        setViews()
        setDatePicker()
    }
    
    private func setDatePicker() {
        
        dateField.inputView = picker
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: UserDefaults.standard.string(forKey: "currentLang") ?? "ru")
//        picker.locale = Locale(identifier: "rus") // ru_RU
        picker.addTarget(self, action: #selector(dateDidPicked), for: .allEvents)
    }
    
    @objc func dateDidPicked() {
        self.selectedDate = picker.date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        dateField.text = formatter.string(from: picker.date)
    }
    
    private func setViews() {
        
        bodyField.layer.borderColor = UIColor.systemGray6.cgColor
        bodyField.layer.borderWidth = 1
        bodyField.layer.cornerRadius = 8
        
        headerField.borderStyle = .none
        headerField.layer.borderColor = UIColor.systemGray6.cgColor
        headerField.layer.borderWidth = 1
        headerField.layer.cornerRadius = 8
        
        saveButtonOutlet.layer.cornerRadius = saveButtonOutlet.frame.height / 2
        
        saveButtonOutlet.layer.shadowColor = UIColor.systemMint.cgColor
        saveButtonOutlet.layer.shadowOpacity = 0.3
        saveButtonOutlet.layer.masksToBounds = false
        saveButtonOutlet.layer.shadowRadius = 10
        saveButtonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        saveButtonOutlet.layer.shouldRasterize = true
        saveButtonOutlet.layer.rasterizationScale = UIScreen.main.scale
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        guard let header = headerField.text,
              let body = bodyField.text,
              let date = selectedDate else { return }
        
        if header != "", body != "" {
            task.header = header
            task.body = body
            task.date = date
            
            saveTask?()
            
        } else {
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension TaskViewController: LanguageUpdatable {
    
    @objc func updateLanguage() {
        
        headerLabel.text = AppLocalizationKeys.editHeader.localized()
        bodyLabel.text = AppLocalizationKeys.editBody.localized()
        dateLabel.text = AppLocalizationKeys.editDate.localized()
        saveButtonOutlet.titleLabel?.text = AppLocalizationKeys.editSave.localized()
    }
    
    func subscribeToNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChange"), object: nil)
    }
}
