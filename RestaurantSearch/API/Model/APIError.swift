//
//  APIError.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/06/27.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

private struct APIErrorResponseBody: Codable {
    let error: APIError
}

private struct APIErrorArrayResponseBody: Codable {
    let error: [APIError]
}

struct APIError: Codable, LocalizedError {
    let message: String
    
    var errorDescription: String? {
        return message
    }
}

func errorFromData(_ data: Data) throws -> APIError {
    
    do {
        return try JSONDecoder().decode(APIErrorArrayResponseBody.self, from: data).error[0]
    } catch {
       //
    }    
    return try JSONDecoder().decode(APIErrorResponseBody.self, from: data).error
}
