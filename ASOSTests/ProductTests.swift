//
//  ProductTests.swift
//  ProductTests
//
//  Created by Vasileios Loumanis on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import XCTest
@testable import ASOS

class ProductTests: XCTestCase {
    
    var dictionary: JSONDictionary?
    var product: Product?
    var products: [Product]?
    
    func createProduct() {
        
        dictionary = [
            "BasePrice":30.0,
            "Brand":"ASOS",
            "CurrentPrice":"£30.00",
            "HasMoreColours":true,
            "IsInSet":false,
            "PreviousPrice":"",
            "ProductId":1743838,
            "ProductImageUrl":[
                "http://images.asos.com/inv/media/8/3/8/3/1743838/creamblack/image1xl.jpg"
            ],
            "RRP":"",
            "Title":"ASOS Blouse With Tipped Drop Collar"
        ]
        product = try? Product(dictionary: dictionary!)
    }
    
    func createProductDetails() {
        
        dictionary = [
            "BasePrice":35.0,
            "Brand":"ASOS",
            "CurrentPrice":"£35.00",
            "InStock":true,
            "IsInSet":false,
            "PreviousPrice":"",
            "PriceType":"Full",
            "ProductId":1703489,
            "ProductImageUrls":[
                "http://images.asos.com/inv/media/9/8/4/3/1703489/red/image1xxl.jpg",
                "http://images.asos.com/inv/media/9/8/4/3/1703489/image2xxl.jpg",
                "http://images.asos.com/inv/media/9/8/4/3/1703489/image3xxl.jpg",
                "http://images.asos.com/inv/media/9/8/4/3/1703489/image4xxl.jpg"
            ],
            "RRP":"",
            "Sku":"101050",
            "Title":"ASOS Fringe Sleeve Mesh Crop",
            "AdditionalInfo":"100% Polyester\n\n\n\n\n\nSIZE & FIT \n\nModel wears: UK 8/ EU 36/ US 4\n\n\n\nSize UK 8/ EU 36/ US 4 side neck to hem measures: 46cm/18in"
        ]
        product = try? Product(dictionary: dictionary!)
    }
    
    func createProducts() {
        let fileURL = Bundle(for: type(of: self)).url(forResource: "products", withExtension: "json")!
        let	data = try! Data(contentsOf: fileURL)
        let dictionary = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! JSONDictionary
        products = Product.array(json: dictionary)
    }
    
    func testProductInitializationSucceeds() {
        createProduct()
        XCTAssertNotNil(product)
    }

    func testProductJsonParseSucceeds() {
        createProduct()
        XCTAssertEqual(product?.basePrice, 30.0)
        XCTAssertEqual(product?.brand, "ASOS")
        XCTAssertEqual(product?.currentPrice, "£30.00")
        XCTAssertEqual(product?.hasMoreColours, true)
        XCTAssertEqual(product?.isInSet, false)
        XCTAssertEqual(product?.previousPrice, "")
        XCTAssertEqual(product?.productId, 1743838)
        XCTAssertEqual(product?.productImageUrls.first, "http://images.asos.com/inv/media/8/3/8/3/1743838/creamblack/image1xl.jpg")
        XCTAssertEqual(product?.rrp, "")
        XCTAssertEqual(product?.title, "ASOS Blouse With Tipped Drop Collar")
    }

    func testProductsInitializationSucceeds() {
        createProducts()
        XCTAssertNotNil(products)
    }
    
    func testProductsJsonParseSucceeds() {
        createProducts()
        XCTAssertEqual(products?.count, 33)
    }
    
    func testProductDetailsInitializationSucceeds() {
        createProductDetails()
        XCTAssertNotNil(product)
    }
    
    func testProductDetailsJsonParseSucceeds() {
        createProductDetails()
        XCTAssertEqual(product?.basePrice, 35.0)
        XCTAssertEqual(product?.brand, "ASOS")
        XCTAssertEqual(product?.currentPrice, "£35.00")
        XCTAssertEqual(product?.isInSet, false)
        XCTAssertEqual(product?.previousPrice, "")
        XCTAssertEqual(product?.productId, 1703489)
        XCTAssertEqual(product?.productImageUrls.first, "http://images.asos.com/inv/media/9/8/4/3/1703489/red/image1xxl.jpg")
        XCTAssertEqual(product?.productImageUrls.count, 4)
        XCTAssertEqual(product?.rrp, "")
        XCTAssertEqual(product?.title, "ASOS Fringe Sleeve Mesh Crop")
        XCTAssertEqual(product?.inStock, true)
        XCTAssertEqual(product?.priceType.rawValue, "Full")
        XCTAssertEqual(product?.sku, "101050")
        XCTAssertEqual(product?.additionalInfo, "100% Polyester\n\n\n\n\n\nSIZE & FIT \n\nModel wears: UK 8/ EU 36/ US 4\n\n\n\nSize UK 8/ EU 36/ US 4 side neck to hem measures: 46cm/18in")
    }
}
