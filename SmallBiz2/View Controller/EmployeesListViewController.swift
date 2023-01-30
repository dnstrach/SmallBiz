//
//  ViewController.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/20/22.
//

import UIKit
//cocoa touch class file

class EmployeesListViewController: UIViewController {
    
    //outlets
    //manipulating data
    @IBOutlet weak var employeeTextField: UITextField!
    @IBOutlet weak var employeeListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmployeeController.shared.loadFromPersistenceStore()
        // Do any additional setup after loading the view.
        setupTableView()
        //employeeListTableView.dataSource = self
        //employeeListTableView.delegate = self
        
    }
    
    //setupTableView method
    //datasource supplying data
    //delegate supplies behavior
    //why setting equal to self? - will be handled in this file
    func setupTableView() {
        employeeListTableView.dataSource = self
        employeeListTableView.delegate = self
    }
    
    //action button
    //registering button "click/tap"
    @IBAction func addButtonTapped(_ sender: Any) {
        
        //guard protects from optionals - input strings are optional
        //text field can not be optional/nil to add an employee
        //have to return at end of guard statement..if conditions are not met bail from function
        //!text.isEmpty preventing an added empty string
        //referencing text from text in employee text field outlet
        guard let text = employeeTextField.text, !text.isEmpty else {
            return
        }
        
        //Split first and last name(text) into 2 objects
        let fullName = text.components(separatedBy: " ")
        
        if fullName.count >= 2 {
        //EmployeeController.shared.addEmployee(firstName: text, lastName: text)
        //error --> adds employees name twice
        EmployeeController.shared.addEmployee(firstName: fullName[0], lastName: fullName[1])
        //why index 0 and index 1? ["Dominique", "Strachan"]
        } else { EmployeeController.shared.addEmployee(firstName: fullName[0], lastName: "") }
        //find way to crash gracefully
        
        //resetting text field to be an empty string after tapping employee buton
        employeeTextField.text = ""
        
        //referencing table view outlet
        //reload data after adding new employee to refresh and submit
        employeeListTableView.reloadData()
        
    }
    
// MARK: - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //IIDDOO
        if segue.identifier == "toEmployeeTask" {
            //setting up imdexPath for clicking on employee row in employee table view
            guard let indexPath = employeeListTableView.indexPathForSelectedRow,
                  //destination is the task table view
                    let destination = segue.destination as? EmployeeTaskListViewController else { return }
            //pulling from employees array in employee controller file with subscript at selected employee in employee table view at its row int
            let employee = EmployeeController.shared.employees[indexPath.row]
            //final destination contains employee array and is equal so selected employee
            destination.employee = employee
        }
    }
}

//Note: functions are given below if created new cocoa touch file with:
//Class: EmployeeTableViewController
//subtitle of UITableViewController

//why do we not use override func??
extension EmployeesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //1 section is default for table views
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    //numbers rows set to amount of objects in employee - can't hardcode a number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //no good because does not account for instances on left and right handside?
        //let employeeController = EmployeeController()
        //employeeCont.employees
        //return
        
        //referencing employees array in employee controller
        //shared instance - need single instance of employee controller that can be accessed by all functions
        //employees array needs static keyword
        EmployeeController.shared.employees.count
    }
    
    //creating cells for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //add string cell indentifier from table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        
        
        //first run will be section 0 row 0 -->first employee...second run will be section 0 row 1 -->second employee...
        //subscripting into array with indexPath.row
        //referred to shared - single instance
        let employee = EmployeeController.shared.employees[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        //add EmployeeListViewController class to table view
        //cell.textLabel?.text = "This should be added employee"
        content.text = "\(employee.firstName) \(employee.lastName)"
        content.secondaryText = "Level: \(employee.skillLevel)"
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    //removing highlight after clicking employee
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //delay execution of the deselect method to 1/4 of a second after .now()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employeeToDelete =
            //using shared instance from empController by subscripting indexPath.row
            EmployeeController.shared.employees[indexPath.row]
            //passing in employee to delete with deleteEmployee function from empController
            EmployeeController.shared.deleteEmployee(employee: employeeToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
    


