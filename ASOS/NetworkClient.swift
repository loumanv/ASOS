//
//  NetworkClient.swift
//  ASOS
//
//  Created by Vasileios Loumanis on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import Alamofire

typealias JSONDictionary = [String: Any]

struct UrlStrings {
    static let baseUrl = "https://mobile.asosservices.com/sampleapifortest"
    static let anyCatProducts = "/anycat_products.json"
    static let anyProductDetails = "/anyproduct_details.json"
    static let productIdParameterKey = "catid="
}

struct NetworkClientError {
    static let jsonResponseEmpty = AppError(localizedTitle: "JSON Response Empty", localizedDescription: "JSON Response Empty", code: 0)
}

class NetworkClient {
    
    public static let shared = NetworkClient()
    
    func load(urlString: String, parameters: [String: String]? = nil, completion: @escaping ((Any?, Error?) -> Void)) {
        Alamofire.request(urlString, parameters: parameters).responseJSON { response in
            
            switch response.result {
            case .success(let data):
                completion(data, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func loadProducts(completion: @escaping (([Product]?, AppError?) -> Void)) {
        load(urlString: UrlStrings.baseUrl + UrlStrings.anyCatProducts) { (data, error) in
            guard error == nil,
                let data = data,
                let json = data as? JSONDictionary else {
                    if let error = error {
                        completion(nil, error as? AppError)
                    }
                    completion(nil, NetworkClientError.jsonResponseEmpty)
                    return
            }
            
            let products = Product.array(json: json)
            completion(products, nil)
        }
    }
    
    func loadProduct(productId: Int, completion: @escaping ((Product?, AppError?) -> Void)) {

        let parameters = [UrlStrings.productIdParameterKey: String(productId)]
        load(urlString: UrlStrings.baseUrl + UrlStrings.anyProductDetails, parameters: parameters) { (data, error) in
            guard error == nil,
                let data = data,
                let json = data as? JSONDictionary else {
                    if let error = error {
                        completion(nil, error as? AppError)
                    }
                    completion(nil, NetworkClientError.jsonResponseEmpty)
                    return
            }
            do {
                let productDetails = try Product(dictionary: json)
                completion(productDetails, nil)
            } catch {
                completion(nil, error as? AppError)
            }
        }
    }
}
