//
//  TaskTableViewCell.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/23/22.
//

//cocoa touch class file for custom cell

import UIKit

struct CellImages {
    static let incomplete: UIImage = UIImage(systemName: "circle")!
    static let complete: UIImage = UIImage(systemName: "circle.inset.filled")!
}

//protocol - define the requirements in the form of methods, but do not write the method bodies
protocol TaskStatusChangedProtocol: AnyObject {
    func updateTaskStatus(task: Task)
}

class TaskTableViewCell: UITableViewCell {


    //MARK: Outlets
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskButton: UIButton!
    
    //declaring property for delegate
    weak var delegate: TaskStatusChangedProtocol?
    //new property task of Task type
    var task: Task! {
        //didSet, is a little block of code that will run everytime this property gets set. So, the moment we assign this cell a task, this code will run
        didSet {
            updateViews()
        }
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    //MARK: Actions
    @IBAction func doneButtonTapped(_ sender: Any) {
        //calling on delegate protocol passing in task
        delegate?.updateTaskStatus(task: task)
    }
    
    //cell images define in struct at the top
    func updateViews() {
        taskTitleLabel.text = task.title
        //if task.isComplete we’ll use the complete image, otherwise we will use the incomplete image
        taskButton.setImage(task.isComplete ? CellImages.complete : CellImages.incomplete, for: .normal)
    }
}
