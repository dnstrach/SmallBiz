//
//  EmployeeTaskListViewController.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/21/22.
//

import UIKit

class EmployeeTaskListViewController: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var taskTableView: UITableView!
    
    // MARK: - Properties
    //provides access to employee array from the employee model
    var employee: Employee!
    
    override func loadView() {
        super.loadView()
        //taskTableView.dataSource = self
        //taskTableView.delegate = self
        setupViewTitle()
    }
    
    //code execution can be added to loadView()
    //spearating the functions for cleaner code
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    //adding title to nav bar
    func setupViewTitle() {
        self.navigationItem.title = "\(employee.firstName)'s Tasks"
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        //capturing the text in textField and ensure it is not empty 
        guard let text = taskTextField.text, !text.isEmpty else { return }
        //calling on function from task controller and passing in selected employee and added task title from this file
        TaskController.assignTaskTo(employee, taskTitle: text)
        //resetting text field to be an empty string after tapping employee buton
        taskTextField.text = ""
        //removes keyboard after tasks is added for space on screen
        taskTextField.resignFirstResponder()
        
        //referencing table view outlet
        //reload data after adding new employee to refresh and submit
        taskTableView.reloadData()
    }
}

//conforming to UITableViewDelegate and UITableViewDataSource with required methods
extension EmployeeTaskListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //creating number of rows objects in the tasks array in the employee model
        employee.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //setting cell indentifer to name of cell in task table
        //let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        //adjusting new cell to follow our custom cell
        //display info in task table view cell or return blank table view cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as?
            //return vanilla UITableViewCell
            TaskTableViewCell else { return UITableViewCell() }
        
        //task is from the tasks array/property in the employees array at row number within its row/section
        let task = employee.tasks[indexPath.row]
        
        //content variable boiler plate
        //no longer need contentConfiguration since using custom cell not basic tableViewCell
        //var content = cell.defaultContentConfiguration()
        //text within configuring the cell is title property from the task model
        //content.text = task.title
        //content.text = "testing task cell"
        
        cell.task = task
        //conforming to protocol?
        cell.delegate = self
        
        //cell.taskTitleLabel.text = task.title
        
        //finalizing cell configuration boiler plate
        //no longer need contentConfiguration since using custom cell not basic tableViewCell
        //cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //creating variable to store the selected task from its section/row row int in employee object containing matching task in task array
            let taskToDelete = employee.tasks[indexPath.row]
            //calling on delete task function from the task controller
            //passing in employee array with selcted task to delete
            TaskController.deleteTaskFrom(employee, taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//extension for protocol
extension EmployeeTaskListViewController: TaskStatusChangedProtocol {
    func updateTaskStatus(task: Task) {
        //calling on taskController passing in employee and task after setting up toggleTaskStatus function
        TaskController.toggleTaskStatus(employee: employee, task: task)
        //reload to show toggle or else won't show unil next click with automatic reload
        taskTableView.reloadData()
    }
}

