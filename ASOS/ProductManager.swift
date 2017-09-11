//
//  Favourites.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 10/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

protocol ProductManager {
    associatedtype SharedProductManager
    static var shared: SharedProductManager { get }
    var products: [Product] { get set }
    mutating func add(product: Product)
    mutating func remove(product: Product)
    func numberOfItems() -> Int
    func numberOfItemsPerId() -> [String: Int]
    func itemsDescription() -> String
}

extension ProductManager {
    
    mutating func add(product: Product) {
        products.append(product)
    }
    
    mutating func remove(product: Product) {
        if let index = products.index(where: {$0 == product}) {
            products.remove(at: index)
        }
    }
    
    func numberOfItems() -> Int {
        return products.count
    }
    
    func numberOfItemsPerId() -> [String: Int] {
        var list: [String: Int] = [:]
        
        for product in products {
            list[String(product.productId)] = (list[String(product.productId)] ?? 0) + 1
        }
        return list
    }
    
    func itemsDescription() -> String {
        return numberOfItemsPerId().map { "\($0):\($1)" }.joined(separator: "\n")
    }
}

class ShoppingBag: ProductManager {
    
    static var shared = ShoppingBag()
    
    internal var products: [Product] = []
}

class Favourites: ProductManager {
    
    static var shared = Favourites()
    
    internal var products: [Product] = []
    
    func isInFavourites(product: Product) -> Bool {
        guard products.index(where: {$0 == product}) != nil else { return false }
        return true
    }
}
