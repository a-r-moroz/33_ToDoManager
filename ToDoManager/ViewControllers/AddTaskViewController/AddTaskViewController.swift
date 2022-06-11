//
//  AddTaskViewController.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var headerField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var viewWithData: UIView!
    
    var addTask: (() -> ())?
    var newTask = Task()
    var picker = UIDatePicker()
    var selectedDate: Date?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setViews()
        closeController()
        subscribeToNotification()
        updateLanguage()

        setDatePicker()
    }
    
    func setDatePicker() {
        
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
    
    func setViews() {
        
//        headerField.borderStyle = .none
//        headerField.layer.borderColor = UIColor.systemGray5.cgColor
//        headerField.layer.borderWidth = 1
//        headerField.layer.cornerRadius = 8
        
        bodyField.layer.borderColor = UIColor.systemGray6.cgColor
        bodyField.layer.borderWidth = 1
        bodyField.layer.cornerRadius = 8
        
        headerField.borderStyle = .none
        headerField.layer.borderColor = UIColor.systemGray6.cgColor
        headerField.layer.borderWidth = 1
        headerField.layer.cornerRadius = 8
        
        buttonOutlet.layer.cornerRadius = buttonOutlet.frame.height / 2
            
        buttonOutlet.layer.shadowColor = UIColor.systemMint.cgColor
        buttonOutlet.layer.shadowOpacity = 0.3
        buttonOutlet.layer.masksToBounds = false
        buttonOutlet.layer.shadowRadius = 10
        buttonOutlet.layer.shadowOffset = CGSize(width: 5, height: 5)
        buttonOutlet.layer.shouldRasterize = true
        buttonOutlet.layer.rasterizationScale = UIScreen.main.scale
        
        viewWithData.layer.cornerRadius = 18
        viewWithData.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func closeController() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTap(sender:)))
        backgroundImage.isUserInteractionEnabled = true
        backgroundImage.addGestureRecognizer(tap)
    }
    
    @objc func closeTap(sender: UITapGestureRecognizer) {
        
        dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        guard let header = headerField.text,
              let body = bodyField.text,
              let date = selectedDate else { return }
        
        if header != "", body != "" {
            newTask.header = header
            newTask.body = body
            newTask.date = date
            
            addTask?()
        } else {
            return
        }



        
        dismiss(animated: true)
    }
}


extension AddTaskViewController: LanguageUpdatable {
    
    @objc func updateLanguage() {
        
        headerLabel.text = AppLocalizationKeys.header.localized()
        bodyLabel.text = AppLocalizationKeys.body.localized()
        dateLabel.text = AppLocalizationKeys.date.localized()
        addButtonOutlet.titleLabel?.text = AppLocalizationKeys.add.localized()
    }
    
    func subscribeToNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChange"), object: nil)
    }
}
