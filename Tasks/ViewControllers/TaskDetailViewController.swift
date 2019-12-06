//
//  TaskDetailViewController.swift
//  Tasks
//
//  Created by Joseph Rogers on 12/3/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var priorityControl: UISegmentedControl!
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       updateViews()
    }
    
    //MARK: Actions
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
                 !name.isEmpty else {return}
        //makes an index, puts that indexed priority into the all priorities property and get the proper priority
        let priorityIndex = priorityControl.selectedSegmentIndex
        let priority = TaskPriority.allPriorities[priorityIndex]
        
        let notes = notesTextView.text
        
        if let task = task {
            // Editing an existing task, changed the task in our MOC interface as well.
            task.name = name
            task.priority = priority.rawValue
            task.notes = notes
        } else {
            // Creating a new task, and put it in our managed object context!
            let _ = Task(name: name, priority: priority, notes: notes)
        }
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard isViewLoaded else {return}
        
        title = task?.name ?? "Create Task"
        nameTextField.text = task?.name
        
        let priority: TaskPriority
        if let taskPriority = task?.priority {
            priority = TaskPriority(rawValue: taskPriority)!
        } else {
            priority = .normal
        }
        
        priorityControl.selectedSegmentIndex = TaskPriority.allPriorities.firstIndex(of: priority)!
        
        notesTextView.text = task?.notes
    }
    
    
    
}
