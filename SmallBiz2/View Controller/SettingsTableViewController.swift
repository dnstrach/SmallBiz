//
//  SettingsTableViewController.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/23/22.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //defining datasource to implement delegate methods
    lazy var datasource: [SettingsItem] = {
        var item = SettingsItem(settingTitle: "New Employee default items", isActive: false, type: .toggleSwitch)
        item.readDefaults()
        var secondItem = SettingsItem(settingTitle: "Default Items", isActive: false, type: .disclosure)
        return [item, secondItem]

    }()

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datasource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //grabbing item by subscripting into datasource
        let item = datasource[indexPath.row]

        switch item.type {

        case .toggleSwitch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            cell.item = item
            cell.delegate = self
            return cell

        case .disclosure:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "disclosureCell", for: indexPath) as? DisclosureTableViewCell else { return UITableViewCell() }
            cell.disclosureCellLabel.text = item.settingTitle

            return cell
            
            //text from SettingsItem struct
//            cell.settingsLabel.text = item.settingTitle
//            cell.settingsSwitch.isOn = item.isActive
            
        }
    }
}

//extension for adopting settingToggled method
extension SettingsTableViewController: SettingChangedProtocol {
    func settingToggled(item: SettingsItem) {
        //setting values at certain keys
        //taking opposite of current isActive property and saving as new isActive state
        UserDefaults.standard.set(!item.isActive, forKey: item.settingTitle)
        
    }
}

//building block for datasource
struct SettingsItem {
    var settingTitle: String
    var isActive: Bool 
    var type: SettingCellType
    
    //checking that value to ensure switch starts on the right state when user arrives at the view
    //mutating to allow mutate self to get around immutable
    mutating func readDefaults() {
        let defaults = UserDefaults.standard
        //returning value at given key
        self.isActive = defaults.bool(forKey: self.settingTitle)
    }
}

//defining SettingCellType
enum SettingCellType {
    case toggleSwitch
    case disclosure
}
