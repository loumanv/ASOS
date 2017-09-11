//
//  ProductDetailsViewController.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 09/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseController {
    
    var viewModel: ProductDetailsViewModel?
    let networkClient = NetworkClient.shared

    @IBOutlet weak var imagesCollectionView: UICollectionView! {
        didSet {
            imagesCollectionView.register(UINib(nibName: String(describing: ImageCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ImageCell.self))
        }
    }
    @IBOutlet weak var additionalInfoTextView: UITextView!
    @IBOutlet weak var addToBagButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Decided to fetch product details here and not in the previous view in order to use the pre-existing object to prepopulate this view and let the fetch to
        // happen in the background. In our case the product and the image of the product is different except if you choose the same product that we get in the
        // details screen.
        fetchProductDetails()
    }
    
    func fetchProductDetails() {
        networkClient.loadProduct(productId: (viewModel?.product?.productId)!) { [weak self] product, error  in
            guard error == nil else {
                self?.showErrorMessage(title: error?.localizedTitle, message: error?.localizedDescription)
                return
            }
            guard let product = product else { return }
            self?.viewModel?.product = product
            self?.imagesCollectionView.reloadData()
            self?.additionalInfoTextView.text = self?.viewModel?.additionalInfo()
            self?.addToBagButton.setTitle(self?.viewModel?.addToButtonTitle(), for: .normal)
        }
    }

    @IBAction func addToBagButtonPressed(_ sender: Any) {
        guard let product = viewModel?.product else { return }
        ShoppingBag.shared.add(product: product)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionView Protocols

extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = viewModel?.product?.productImageUrls.count ?? 0
        return viewModel?.product?.productImageUrls.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCell.self), for: indexPath) as? ImageCell else { return ImageCell() }
        if let imageUrl = viewModel?.imageURLFor(row: indexPath.row) {
            cell.imageView.af_setImage(withURL: imageUrl, imageTransition: .crossDissolve(0.30))
        }
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageWidth = imagesCollectionView.frame.size.width
        pageControl.currentPage = Int(imagesCollectionView.contentOffset.x / pageWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
    }
}
