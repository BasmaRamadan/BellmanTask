//
//  CollectionCell.swift
//  Task
//
//  Created by Basma on 12/13/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var collectionCellViewModel : ItemCellViewModel? {
        didSet {
            titleLabel.text = collectionCellViewModel?.name ?? ""
            descriptionLabel.text = collectionCellViewModel?.description ?? ""
            if collectionCellViewModel?.photos.count != 0{
                let photoUrl = collectionCellViewModel?.photos[0].replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
                itemImageView?.sd_setImage(with: URL( string: photoUrl ?? ""), completed: nil)
 
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
