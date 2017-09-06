//
//  ASOSTests.swift
//  ASOSTests
//
//  Created by Billybatigol on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import ASOS



class ASOSTests: XCTestCase {
    
    var dictionary: [String: Any]?
    var category: Category?
    var categories: [Category]?
    
    func createCategory() {
        
        dictionary = [
            "CategoryId":"catalog01_1001_7618",
            "Name":"Jumpsuits & Playsuits",
            "ProductCount":115
        ]
        category = try? Category(dictionary: dictionary!)
    }
    
    func createCategories() {
        let fileURL = Bundle(for: type(of: self)).url(forResource: "categories", withExtension: "json")!
        let	data = try! Data(contentsOf: fileURL)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        categories = Category.parseCategories(json: dictionary)
    }
    
    func testCategoryInitializationSucceeds() {
        createCategory()
        XCTAssertNotNil(category)
    }

    func testCategoryJsonParseSucceeds() {
        createCategory()
        XCTAssertEqual(category?.categoryId, "catalog01_1001_7618")
        XCTAssertEqual(category?.name, "Jumpsuits & Playsuits")
        XCTAssertEqual(category?.productCount, 115)
    }

    func testCategoriesInitializationSucceeds() {
        createCategories()
        XCTAssertNotNil(categories)
    }
    
    func testCategoriesJsonParseSucceeds() {
        createCategories()
        XCTAssertEqual(categories?.count, 16)
    }
}
