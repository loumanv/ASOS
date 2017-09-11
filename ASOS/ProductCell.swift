//
//  ProductCell.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 07/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

protocol ProductCellOutput {
    func favouriteButtonPressed(sender: ProductCell)
}

class ProductCell: UICollectionViewCell {

    var cellOutput: ProductCellOutput?
    var isFavourite: Bool = false {
        didSet {
            favouriteButton.setImage(isFavourite ? UIImage(named: "full_heart") : UIImage(named: "empty_heart"), for: .normal)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBAction func favouriteButtonPressed(_ sender: Any) {
        cellOutput?.favouriteButtonPressed(sender: self)
    }
}
