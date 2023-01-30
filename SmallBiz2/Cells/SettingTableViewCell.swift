//
//  SettingTableViewCell.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/23/22.
//

import UIKit

//cannot be nested inside another declaration
protocol SettingChangedProtocol: AnyObject {
    //required method taking in SettingsItem arg
    func settingToggled(item: SettingsItem)
}

class SettingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: SettingChangedProtocol?
    //item that is toggled
    var item: SettingsItem! {
        //did set gets called everytime a settings item is toggled
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        settingsLabel.text = item.settingTitle
        settingsSwitch.isOn = item.isActive
    }

    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var settingsSwitch: UISwitch!
    
    
    @IBAction func switchToggled(_ sender: Any) {
        //calling settingToggled method via delegate
        delegate?.settingToggled(item: item)
    }
    

}
