//
//  TaskTableViewController.swift
//  Tasks
//
//  Created by Joseph Rogers on 12/3/19.
//  Copyright © 2019 Joseph Rogers. All rights reserved.
//

import UIKit
import CoreData

class TaskTableViewController: UITableViewController {
    
    //MARK: Properties
    
    //creates an array of tasks.
    //TODO: Make this more efficient.
    //creating a task fetch request every time it is accessed.
    private var tasks: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            print("Error fetching task data: \(error)")
            return []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
                let task = tasks[indexPath.row]
                cell.textLabel?.text = task.name
        
                return cell
    }
    
    //MARK: Actions
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            let moc = CoreDataStack.shared.mainContext
            moc.delete(task)
            do {
                try moc.save()
                tableView.reloadData()
            } catch {
                moc.reset()
                print("Error saving MOC object context: \(error)")
            }
        }
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailVC" {
            let detailVC = segue.destination as! TaskDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.task = tasks[indexPath.row]
            }
        }
    }
    

}
