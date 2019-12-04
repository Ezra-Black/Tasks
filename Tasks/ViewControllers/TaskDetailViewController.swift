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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
    }
    
    
}
