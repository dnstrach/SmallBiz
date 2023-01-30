//
//  DefaultItemsCollectionViewCell.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/26/22.
//

import UIKit

class DefaultItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var defaultItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 8
    }
    
}
