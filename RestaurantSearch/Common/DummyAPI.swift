//
//  DummyAPI.swift
//  RestaurantSearch
//
//  Created by 岩永 彩里 on 2019/05/20.
//  Copyright © 2019年 岩永 彩里. All rights reserved.
//

import Foundation

class DummyAPI: APIType {
    var area = AreaResponseBody(areaList: [Area(areaCode: "000", areaName: "九州")])
    var prefecture = PrefectureResponseBody(prefectureList: [Prefecture(prefCode: "111",
                                                                        prefName: "福岡県",
                                                                        areaCode: "222")])
    var city = CityResponseBody(cityList: [City(cityCode: "333",
                                                cityName: "大濠・六本松・桜坂",
                                                pref: City.Pref(prefCode: "444",
                                                                prefName: "福岡県"))])
    var town = TownResponseBody(townList: [Town(townCode: "555",
                                                townName: "桜坂・小笹",
                                                city: Town.AreaL(cityCode: "666",
                                                                 cityName: "大濠・六本松・桜坂"))])
    var shop = ShopResponseBody(shop: [Shop(id: "fap1004",
                                            name: "店の名前",
                                            nameKana: "カタカナ",
                                            latitude: "緯度",
                                            longitude: "経度",
                                            category: "カテゴリー",
                                            imageUrl: Shop.Image(shopImage1: "",
                                                                 shopImage2: "",
                                                                 qrcode: "https://c-r.gnst.jp/tool/qr/?id=h598811&q=6"),
                                            address: "福岡市東区馬出",
                                            tel: "092-642-6900",
                                            opentime: "18:00~24:00",
                                            holiday: "不定休日あり",
                                            pr: Shop.Pr(prShort: "すっごく美味しいですよ〜",
                                                        prLong: "今泉に11月NEWオープン!!!\n貸切宴会や飲み会、結婚式二次会にオススメ！\n・交通アクセス\n西鉄天神駅より徒歩3分\n・プラン\n地域最安値の2,500円～\n・席\n着席70名、立席120名\n・特典\n①カラオケ無料\n②新郎新婦無料"),
                                            code: Shop.Code(genre: ["広島風お好み焼き", ""]))])
    
    func getArea(success: @escaping (AreaResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(area)
    }
    
    func getPrefecture(success: @escaping (PrefectureResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(prefecture)
    }
    
    func getCity(success: @escaping (CityResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(city)
    }
    
    func getTown(success: @escaping (TownResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(town)
    }
    
    func getShop(townCode: String, freeword: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(shop)
    }
    
    func getShopByID(shopID: String, success: @escaping (ShopResponseBody) -> Void, failure: @escaping (Error) -> Void) {
        success(shop)
    }
}
