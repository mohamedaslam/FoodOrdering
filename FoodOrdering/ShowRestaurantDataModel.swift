//
//  ShowRestaurantDataModel.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2020/1/8.
//  Copyright © 2020 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit

class RestaurantMainDataModel: NSObject {

       var sessionType: String?
       var sessionName: String?
       var promotions: String?
       var categories:[CategoryDataModel]?
       var restaurants: [RestaurantDataModel]?
       
       init(sessionType: String?,
            sessionName: String?,
            promotions: String?,
            categories: [CategoryDataModel]?,
            restaurants: [RestaurantDataModel]?) {
           self.sessionType = sessionType ?? ""
           self.sessionName = sessionName ?? ""
           self.promotions = promotions ?? ""
           self.categories = categories ?? []
            self.restaurants = restaurants ?? []
       }
}
class RestaurantDataModel: NSObject {

       var restaurantID: String?
       var restaurantName: String?
       var restaurantImage: String?
       var restaurantRatings: String?
       var restaurantTime: String?
       var currentStatus: String?
       var promotion: String?
       var isUserfavorites : Bool
       
       init(restaurantID: String?,
            restaurantName: String?,
            restaurantImage: String?,
            restaurantRatings: String?,
            restaurantTime: String?,
            currentStatus: String?,
            promotion: String?,
            isUserfavorites: Bool?) {
           self.restaurantID = restaurantID ?? ""
           self.restaurantName = restaurantName ?? ""
           self.restaurantImage = restaurantImage ?? ""
           self.restaurantRatings = restaurantRatings ?? ""
           self.restaurantTime = restaurantRatings ?? ""
           self.currentStatus = restaurantRatings ?? ""
           self.promotion = restaurantRatings ?? ""
           self.isUserfavorites = isUserfavorites ?? true
       }
}
class CategoryDataModel: NSObject {

       var categoryID: String?
       var categoryName: String?
       var categoryImage: String?

       init(categoryID: String?,
            categoryName: String?,
            categoryImage: String?) {
           self.categoryID = categoryID ?? ""
           self.categoryName = categoryName ?? ""
           self.categoryImage = categoryImage ?? ""
       }
}

