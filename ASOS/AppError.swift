//
//  AppError.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 05/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

struct AppError: Error {
    
    var localizedTitle: String
    var localizedDescription: String
    var code: Int
    
    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

