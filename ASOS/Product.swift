//
//  Product.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Foundation

class Product: Equatable {
    
    enum ProductError: LocalizedError {
        case missingBasePrice
        case missingBrand
        case missingCurrentPrice
        case missingIsInSet
        case missingProductId
        case missingProductImageUrl
        case missingTitle
        static let productInitialisationFailed = AppError(localizedTitle: "Product Error", localizedDescription: "Error initialising Product", code: 0)
    }

    enum PriceType: String {
        case Full
    }
    
    var basePrice: Double
    var brand: String
    var currentPrice: String
    var hasMoreColours: Bool
    var isInSet: Bool
    var previousPrice: String
    var productId: Int
    var productImageUrls: [String]
    var rrp: String
    var title: String
    var inStock: Bool
    var priceType: PriceType
    var sku: String
    var additionalInfo: String
    
    init(dictionary: JSONDictionary) throws {
        
        guard let basePrice = dictionary["BasePrice"] as? Double else { throw ProductError.missingBasePrice}
        guard let brand = dictionary["Brand"] as? String else { throw ProductError.missingBrand}
        guard let currentPrice = dictionary["CurrentPrice"] as? String else { throw ProductError.missingCurrentPrice}
        guard let isInSet = dictionary["IsInSet"] as? Bool else { throw ProductError.missingIsInSet}
        guard let productId = dictionary["ProductId"] as? Int else { throw ProductError.missingProductId}
        guard let productImageUrls = (dictionary["ProductImageUrl"] as? [String]) ?? (dictionary["ProductImageUrls"] as? [String]) else { throw ProductError.missingProductImageUrl}
        guard let title = dictionary["Title"] as? String else { throw ProductError.missingTitle}
        
        self.basePrice = basePrice
        self.brand = brand
        self.currentPrice = currentPrice
        self.hasMoreColours = dictionary["HasMoreColours"] as? Bool ?? false
        self.isInSet = isInSet
        self.previousPrice = dictionary["PreviousPrice"] as? String ?? ""
        self.productId = productId
        self.productImageUrls = productImageUrls
        self.rrp = dictionary["RRP"] as? String ?? ""
        self.title = title
        self.inStock = dictionary["InStock"] as? Bool ?? false
        self.priceType = PriceType(rawValue: (dictionary["PriceType"] as? String) ?? "Full") ?? .Full
        self.sku = dictionary["Sku"] as? String ?? ""
        self.additionalInfo = dictionary["AdditionalInfo"] as? String ?? ""
    }
    
    public static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId
    }
}

extension Product {
    static let jsonKey = "Listings"
    
    static func array(json: JSONDictionary) -> [Product] {
        
        guard let productsArray = json[jsonKey] as? [JSONDictionary] else { return [Product]() }
        let products: [Product] = productsArray.flatMap { try? Product(dictionary: $0) }
        return products
    }
}
