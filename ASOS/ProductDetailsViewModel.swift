//
//  ProductDetailsViewModel.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 09/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Foundation

class ProductDetailsViewModel {
    
    var product: Product?
    
    init(product: Product) {
        self.product = product
    }
    
    func imageURLFor(row: Int) -> URL? {
        guard let product = product,
              let imageURL = URL(string: product.productImageUrls[row]) else { return nil }
        return imageURL
    }

    func additionalInfo() -> String {
        guard let product = product else { return "" }
        return product.additionalInfo
    }
    
    func addToButtonTitle() -> String {
        guard let product = product else { return "" }
        return "Add to Bag (\(product.currentPrice))"
    }
}

