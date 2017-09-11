//
//  ProductsViewModel.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Foundation

class ProductsViewModel {

    var products: [Product]?
    
    init(products: [Product]) {
        self.products = products
    }
    
    func imageURLFor(row: Int) -> URL? {
        guard let product = products?[row],
              let firstImageURLString =  product.productImageUrls.first,
              let imageURL = URL(string: firstImageURLString) else { return nil }
        return imageURL
    }
    
    func priceFor(row: Int) -> String {
        guard let product = products?[row] else { return "" }
        return product.currentPrice
    }
    
    func isFavouriteFor(row: Int) -> Bool {
        guard let product = products?[row] else { return false }
        return Favourites.shared.isInFavourites(product: product) ? true : false
    }
}
