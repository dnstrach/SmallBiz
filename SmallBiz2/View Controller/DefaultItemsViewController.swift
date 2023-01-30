//
//  DefaultItemsViewController.swift
//  SmallBiz2
//
//  Created by Dominique Strachan on 12/26/22.
//

import UIKit

class DefaultItemsViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
        top: 30.0,
        left: 20.0,
        bottom: 30.0,
        right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Default Items"
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DefaultItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        EmployeeController.shared.defaultItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultItemCell", for: indexPath) as? DefaultItemsCollectionViewCell else { return UICollectionViewCell() }
        let item = EmployeeController.shared.defaultItems[indexPath.row]
        cell.defaultItemLabel.text = item
        
        return cell
    }
}

extension DefaultItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width - (sectionInsets.left * (itemsPerRow + 1))
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
