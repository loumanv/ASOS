//
//  ProductsViewController.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductsViewController: BaseController {
    
    let numberOfCellsPerRow: CGFloat = 2
    let cellHeightToWidthRatio: CGFloat = 1.28

    var viewModel: ProductsViewModel?

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: String(describing: ProductCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductCell.self))
        }
    }
    var cellWidth: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            cellWidth = (view.frame.width - flowLayout.minimumInteritemSpacing) / numberOfCellsPerRow
        }
    }
}

// MARK: - UICollectionView Protocols

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let productDetailsVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController
        productDetailsVC?.viewModel = ProductDetailsViewModel(product: (viewModel?.products?[indexPath.row])!)
        navigationController?.pushViewController(productDetailsVC!, animated: true)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.products?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductCell.self), for: indexPath) as? ProductCell else { return ProductCell() }
        cell.cellOutput = self
        if let imageUrl = viewModel?.imageURLFor(row: indexPath.row) {
            cell.imageView.af_setImage(withURL: imageUrl, imageTransition: .crossDissolve(0.30))
        }
        cell.priceLabel.text = viewModel?.priceFor(row: indexPath.row)
        cell.isFavourite = viewModel?.isFavouriteFor(row: indexPath.row) ?? false
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellWidth * cellHeightToWidthRatio)
    }
}

// MARK: - ProductCellOutput

extension ProductsViewController: ProductCellOutput {
    func favouriteButtonPressed(sender: ProductCell) {
        guard let selectedIndexPath = collectionView.indexPath(for: sender) else { return }
        guard let selectedProduct = viewModel?.products?[selectedIndexPath.row] else { return }
        if Favourites.shared.isInFavourites(product: selectedProduct) {
            Favourites.shared.remove(product: selectedProduct)
            sender.isFavourite = false
        } else {
            Favourites.shared.add(product: selectedProduct)
            sender.isFavourite = true
        }
    }
}
