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
        
        let notes = notesTextView.text
        
        if let task = task {
            // Editing an existing task, changed the task in our MOC interface as well.
            task.name = name
            task.notes = notes
        } else {
            // Creating a new task, and put it in our managed object context!
            let _ = Task(name: name, notes: notes)
        }
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            print("Error savaing managed object context: \(error)")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard isViewLoaded else {return}
        
        title = task?.name ?? "Create Task"
        nameTextField.text = task?.name
        notesTextView.text = task?.notes
    }
    
    
    
}
