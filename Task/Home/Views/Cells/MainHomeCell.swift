//
//  MainHomeCell.swift
//  Task
//
//  Created by Basma on 12/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class MainHomeCell: UITableViewCell {
        
    var cellsViewModels = [ItemCellViewModel](){
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBAction func viewAllAction(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension MainHomeCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsViewModels.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.itemImageView.image = UIImage(named : "Home_grey_bottom_icon")
        cell.collectionCellViewModel = cellsViewModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 220)
    }
    
}
