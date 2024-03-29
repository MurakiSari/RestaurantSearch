//
//  APIOperater.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/09.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation
import Alamofire

protocol APIType {
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getShop(townCode: String, freeword: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void)
    func getShopByID(shopID: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void)
}

final class APIOperater: APIType {
    private let commonParameters: [String: Any] = [
        "keyid": "0b2b99e35af2ce054236f4f61700284f"
    ]
    
    private func fetchResponse<ResponseType: Decodable>(url: String, parameters: [String: Any], success: @escaping (ResponseType) -> Void, failure: @escaping (Error) -> Void) {
        let finalParameters = commonParameters.merging(parameters) { $1 }
        
        Alamofire.request(url, parameters: finalParameters)
                 .responseData { response in
                    let result = response.result.flatMap { try JSONDecoder().decode(ResponseType.self, from: $0) }
                    switch result {
                    case .success(let object):
                        success(object)
                    case .failure(let error):  // リクエスト失敗のエラー　or ぐるなびAPI上のエラーが入る
                        if let apiError = response.data.flatMap({ try? errorFromData($0) }) {
                            // ぐるなびAPI上のエラー
                            failure(apiError)
                        } else {
                            // リクエスト失敗時のエラー
                            failure(error)
                        }
                    }
                 }
    }
    
    /// エリアの取得
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/AreaSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// 都道府県の取得
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// 市の取得
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// 町の取得
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/"
        fetchResponse(url: url, parameters: [:], success: success, failure: failure)
    }
    
    /// エリア・フリーワードからお店情報の取得
    func getShop(townCode: String, freeword: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
        let parameters: [String: Any] = [
            "areacode_s": townCode,
            "freeword": freeword,
            "hit_per_page": 100
        ]
        fetchResponse(url: url, parameters: parameters, success: success, failure: failure)
    }
    
    /// IDからお店情報を取得
    func getShopByID(shopID: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
        let parameters = [
            "id": shopID
        ]
        fetchResponse(url: url, parameters: parameters, success: success, failure: failure)
    }
}
