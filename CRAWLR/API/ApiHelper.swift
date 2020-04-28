//
//  ApiHelper.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/22/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class ApiHelper {
    
    static let instance = ApiHelper()

    static let baseUrl = "https://crawlr-mobile.herokuapp.com/"
    static let yelpUrl = "https://api.yelp.com/v3/"
    
    static let usersUrl = baseUrl + "users"
    static let settingsUrl = baseUrl + "settings"
    static let drinksUrl = baseUrl + "drinks"
    static let beveragesUrl = baseUrl + "beverages"
    static let yelpBusinessesUrl = yelpUrl + "businesses"
    
    static let YELP_API_KEY = "nyZo2cHfcA_eQhd19chOA5HjLAvPcRDEM2KE5jr7Hfn_6GL4CTvbvJ7zDzBb4_6L-BNuDNgPsF31TwShgJ4Nf3q4Ao-QdXd6rPR9QzKko54CUpj0skm-Wg8qowKhXnYx"
    
    private var yelpAuthHeaders: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(ApiHelper.YELP_API_KEY)" ]
        }
    }

    private init() {}
    
    func getBusinesses(text: String, latitude: Double, longitude: Double, categories: String, callback: @escaping ([Business]?) -> Void) {
        let url = URL(string: ApiHelper.yelpBusinessesUrl + "/search")!

        let parameters: [String: Any] = [
            "text": text,
            "latitude": latitude,
            "longitude": longitude,
            "categories": categories
        ]
        
        Alamofire.SessionManager.default.request(url, method: .get, parameters: parameters, headers: self.yelpAuthHeaders).responseString { response in
            if let businessesResponse = response.translate(to: BusinessesResponse.self) {
                callback(businessesResponse.businesses)
            } else {
                callback(nil)
            }
        }
    }
    
    func getBusiness(id: String, callback: @escaping (Business?) -> Void) {
        let url = URL(string: ApiHelper.yelpBusinessesUrl + "/\(id)")!
        
        Alamofire.SessionManager.default.request(url, method: .get, parameters: nil, headers: self.yelpAuthHeaders).responseString { response in
            if let businessResponse = response.translate(to: Business.self) {
                callback(businessResponse)
            } else {
                callback(nil)
            }
        }
    }
    
    func createUser(user: User, callback: @escaping (User?) -> Void) {
        let url = URL(string: ApiHelper.usersUrl)!
        
        Alamofire.SessionManager.default.request(url, .post, user.asDictionary()).responseString { response in
            if let userResponse = response.translate(to: User.self) {
                callback(userResponse)
            } else {
                callback(nil)
            }
        }
    }
    
    func getUser(email: String, callback: @escaping (User?) -> Void) {
        let url = URL(string: ApiHelper.usersUrl + "/email/\(email)")!
        
        Alamofire.SessionManager.default.request(url, .get, nil).responseString { response in
            if let userResponse = response.translate(to: User.self) {
                callback(userResponse)
            } else {
                callback(nil)
            }
        }
    }
    
    func trackDrink(drink: Drink, callback: @escaping (Drink?) -> Void) {
        let url = URL(string: ApiHelper.drinksUrl)!
        
        Alamofire.SessionManager.default.request(url, .post, drink.asDictionary()).responseString { response in
            if let userResponse = response.translate(to: Drink.self) {
                callback(userResponse)
            } else {
                callback(nil)
            }
        }
    }
}
