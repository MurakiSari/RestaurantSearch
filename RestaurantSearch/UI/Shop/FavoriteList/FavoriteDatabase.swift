//
//  Setting.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/05.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation

final class FavoriteDatabase {
    private let defaults: UserDefaults
    static let shared = FavoriteDatabase(defaults: UserDefaults.standard)
    private static let shopIDsKey: String = "shopID"
    
    private(set) var shopIDList: [String] {
        get {
            let shopID = defaults.object(forKey: type(of: self).shopIDsKey) as? [String]
            return shopID ?? []
        }
        set {
            defaults.set(newValue, forKey: type(of: self).shopIDsKey)
            defaults.synchronize()
        }
    }
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
}