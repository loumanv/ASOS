//
//  Category.swift
//  ASOS
//
//  Created by Billybatigol on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Foundation

class Category {
    
    var dictionary: [String: Any] = [
    "CategoryId":"catalog01_1001_7618",
    "Name":"Jumpsuits & Playsuits",
    "ProductCount":115
    ]
    
    enum CategoryError: LocalizedError {
        case pageCategoryId
        case missingName
        case missingProductCount
    }
    
    var categoryId: String
    var name: String
    var productCount: Int
    
    init(dictionary: [String: Any]) throws {
        
        guard let categoryId = dictionary["CategoryId"] as? String else { throw CategoryError.pageCategoryId}
        guard let name = dictionary["Name"] as? String else { throw CategoryError.missingName}
        guard let productCount = dictionary["ProductCount"] as? Int else { throw CategoryError.missingProductCount}

        self.categoryId = categoryId
        self.name = name
        self.productCount = productCount
    }
}

extension Category {
    static let jsonKey = "Listing"
    
    static func parseCategories(json: [String: Any]) -> [Category] {
        guard let categoriesArray = json[jsonKey] as? [Any] else { return [Category]() }
        let categories: [Category] = categoriesArray.flatMap { categoryDictionary in
                guard let categoryDictionary = categoryDictionary as? [String : Any] else { return nil }
                return try? Category(dictionary: categoryDictionary)
        }
        return categories
    }
}
