//
//  APIError.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/06/27.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

struct APIErrorResponseBody: Codable {
    let error: APIError
}

struct APIError: Codable, LocalizedError {
    let message: String
    
    var errorDescription: String? {
        return message
    }
}