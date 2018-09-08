//
//  ModelData.swift
//  TokopediaTest
//
//  Created by Ernando on 9/7/18.
//  Copyright © 2018 HappyCoding. All rights reserved.
//

import Foundation

struct Status {
    let error: Int
    let message: String
}

struct Shop {
    let id: Int
    let name: String
    let uri: String
    let isGold: Int
    let rating: Int
    let location: String
    let reputationImageUri: String
    let shopLucky: String
    let city: String
}

struct WholeSalePrice {
    let countMin: Int
    let countMax: Int
    let price: String
}

struct Badges {
    let title: String
    let imageUrl: String
    let show: Bool
}

struct DataModel {
    let id: Int
    let name: String
    let uri: String
    let imageUri: String
    let imageUri700: String
    let price: String
    let priceRange: String
    let categoryBreadCrumb: String
    let shop: Shop
    let wholeSalePrice: [WholeSalePrice]
    let badgas: [Badges]
}

final class ModelData: NSObject {
    var status: Status
    var dataModel: [DataModel] = []
    
    init?(dictionary: [String: Any]) {
        var tempError: Int = 0
        var tempMessage: String = ""
        
        if let status = dictionary["status"] as? [String: Any] {
            
            if let error = status["error"] as? Int {
                tempError = error
            }
            
            if let message = status["message"] as? String {
                tempMessage = message
            }
        }
        
        self.status = Status(error: tempError, message: tempMessage)
        
        if let dataModel = dictionary["data"] as? [[String: Any]] {
            var tempId: Int = 0
            var tempName: String = ""
            var tempUri: String = ""
            var tempImageUri: String = ""
            var tempImageUri700: String = ""
            var tempPrice: String = ""
            var tempPriceRange: String = ""
            var tempCategoryBreadCrumb: String = ""
            
            //Shop
            var tempShopId: Int = 0
            var tempShopName: String = ""
            var tempShopUri: String = ""
            var tempShopIsGold: Int = 0
            var tempShopRating: Int = 0
            var tempShopLocation: String = ""
            var tempShopReputationImageUri: String = ""
            var tempShopLucky: String = ""
            var tempShopCity: String = ""
            var tempShop: Shop = Shop(id: tempShopId, name: tempShopName, uri: tempShopUri, isGold: tempShopIsGold, rating: tempShopRating, location: tempShopLocation, reputationImageUri: tempShopReputationImageUri, shopLucky: tempShopLucky, city: tempShopCity)
            
            //WholeSalePrice
            var tempWholeSalePrice: [WholeSalePrice] = []
            
            //Badges
            var tempBadges: [Badges] = []
            
            for data in dataModel {
                if let id = data["id"] as? Int {
                    tempId = id
                }
                
                if let name = data["name"] as? String {
                    tempName = name
                }
                
                if let uri = data["uri"] as? String {
                    tempUri = uri
                }
                
                if let imageUri = data["image_uri"] as? String {
                    tempImageUri = imageUri
                }
                
                if let imageUri700 = data["image_uri_700"] as? String {
                    tempImageUri700 = imageUri700
                }
                
                if let price = data["price"] as? String {
                    tempPrice = price
                }
                
                if let priceRange = data["price_range"] as? String {
                    tempPriceRange = priceRange
                }
                
                if let categoryBreadCrumb = data["category_breadcrumb"] as? String {
                    tempCategoryBreadCrumb = categoryBreadCrumb
                }
                
                if let shop = data["shop"] as? [String: Any] {
                   
                    if let id = shop["id"] as? Int {
                        tempShopId = id
                    }
                    
                    if let name = shop["name"] as? String {
                        tempShopName = name
                    }
                    
                    if let uri = shop["uri"] as? String {
                        tempShopUri = uri
                    }
                    
                    if let isGold = shop["is_gold"] as? Int {
                        tempShopIsGold = isGold
                    }
                    
                    if let rating = shop["rating"] as? Int {
                        tempShopRating = rating
                    }
                    
                    if let location = shop["location"] as? String {
                        tempShopLocation = location
                    }
                    
                    if let reputationImageUri = shop["reputation_image_uri"] as? String {
                        tempShopReputationImageUri = reputationImageUri
                    }
                    
                    if let shopLucky = shop["shop_lucky"] as? String {
                        tempShopLucky = shopLucky
                    }
                    
                    if let city = shop["city"] as? String {
                        tempShopCity = city
                    }
                    
                    tempShop = Shop(id: tempShopId, name: tempShopName, uri: tempShopUri, isGold: tempShopIsGold, rating: tempShopRating, location: tempShopLocation, reputationImageUri: tempShopReputationImageUri, shopLucky: tempShopLucky, city: tempShopCity)
                }
                
                if let wholeSalePrice = data["wholesale_price"] as? [[String: Any]] {
                    var tempCountMin: Int = 0
                    var tempCountMax: Int = 0
                    var tempWSPrice: String = ""
                    
                    for wsp in wholeSalePrice {
                        if let countMin = wsp["count_min"] as? Int {
                            tempCountMin = countMin
                        }
                        
                        if let countMax = wsp["count_max"] as? Int {
                            tempCountMax = countMax
                        }
                        
                        if let wsPrice = wsp["price"] as? String {
                            tempWSPrice = wsPrice
                        }
                        
                        tempWholeSalePrice.append(WholeSalePrice(countMin: tempCountMin, countMax: tempCountMax, price: tempWSPrice))
                    }
                }
                
                if let dataBadges = data["badges"] as? [[String: Any]] {
                    var tempTitle: String = ""
                    var tempBadgesImageUrl: String = ""
                    var tempShow: Bool = false
                    
                    for badges in dataBadges {
                        if let title = badges["title"] as? String {
                            tempTitle = title
                        }
                        
                        if let imageUri = badges["image_url"] as? String {
                            tempBadgesImageUrl = imageUri
                        }
                        
                        if let show = badges["show"] as? Bool {
                            tempShow = show
                        }
                        
                        tempBadges.append(Badges(title: tempTitle, imageUrl: tempBadgesImageUrl, show: tempShow))
                    }
                }
                
                self.dataModel.append(DataModel(id: tempId, name: tempName, uri: tempUri, imageUri: tempImageUri, imageUri700: tempImageUri700, price: tempPrice, priceRange: tempPriceRange, categoryBreadCrumb: tempCategoryBreadCrumb, shop: tempShop, wholeSalePrice: tempWholeSalePrice, badgas: tempBadges))
            }
        }
        
    }
}
