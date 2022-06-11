//
//  TasksViewController.swift
//  33_ToDoManager
//
//  Created by Andrew Moroz on 9.06.22.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tasksTable: UITableView!
    
    var tasks: [Task] = [Task(header: "Купить цветы", body: "Готэм, начало 1980-х годов. Комик Артур Флек живет с больной матерью, которая с детства учит его «ходить с улыбкой». Пытаясь нести в мир хорошее и дарить людям радость, Артур сталкивается с человеческой жестокостью и постепенно приходит к выводу, что этот мир получит от него не добрую улыбку, а ухмылку злодея Джокера.", date: .now)]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateLanguage()
        subscribeToNotification()

        tasksTable.delegate = self
        tasksTable.dataSource = self
//        title = "Задачи"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.systemMint]
        setAddingButton()
        setupTable()
    }
    
    func setupTable() {
        let nib = UINib(nibName: String(describing: TaskCell.self), bundle: nil)
        tasksTable.register(nib, forCellReuseIdentifier: String(describing: TaskCell.self))
    }
    
    private func setAddingButton() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddTaskVC(sender:)))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func showAddTaskVC(sender: UIBarButtonItem) {
        
        let addTaskVC = AddTaskViewController(nibName: String(describing: AddTaskViewController.self), bundle: nil)
        addTaskVC.modalTransitionStyle = .coverVertical
        addTaskVC.modalPresentationStyle = .overFullScreen
        self.present(addTaskVC, animated: true)
        
        addTaskVC.addTask = {
//            print("Current value: \(addTaskVC.headerField.text), \(addTaskVC.bodyField.text)")
            
//            guard let header = addTaskVC.headerField.text,
//                  let body = addTaskVC.bodyField.text else { return }
//            let item = Task(header: header, body: body, date: .now)
//            self.tasks.append(item)
            self.tasks.append(addTaskVC.newTask)

            
            DispatchQueue.main.async {
                self.tasksTable.reloadData()
            }
        }
    }

}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath)
        guard let taskCell = cell as? TaskCell else { return cell }
        taskCell.headerLabel.text = tasks[indexPath.row].header
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy\nHH:mm"
        let dateString = dateFormatter.string(from: tasks[indexPath.row].date)
        taskCell.dateLabel.text = dateString
        
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let taskVC = TaskViewController(nibName: String(describing: TaskViewController.self), bundle: nil)
        taskVC.task = tasks[indexPath.row]
        
        taskVC.saveTask = {
            
            self.tasks[indexPath.row] = taskVC.task
            DispatchQueue.main.async {
                self.tasksTable.reloadData()
            }
        }
        
        navigationController?.pushViewController(taskVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
//            RealmManager.remove(object: self.history[indexPath.row])
//            self.history = RealmManager.read(type: SavedCoordinates.self)
            
            self.tasks.remove(at: indexPath.row)
            self.tasksTable.reloadData()
        }
        let actions = UISwipeActionsConfiguration(actions: [deleteAction])
        return actions
    }
}

extension TasksViewController: LanguageUpdatable {
    
    @objc func updateLanguage() {
        
        self.title = AppLocalizationKeys.tasksTitle.localized()
    }
    
    func subscribeToNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: Notification.Name("LanguageChange"), object: nil)
    }
}
