//
//  ProductsViewModel.swift
//  ASOS
//
//  Created by Billybatigol on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Foundation

class ProductsViewModel: NSObject {

    var products: [Product]?
    
    init(products: [Product]) {
        self.products = products
    }
}
