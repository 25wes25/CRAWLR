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

    static let baseUrl = ""
    static let yelpUrl = "https://api.yelp.com/v3/"
    
    static let instance = ApiHelper()
    static let yelpBusinessesUrl = yelpUrl + "businesses"
    
    static let YELP_API_KEY = "nyZo2cHfcA_eQhd19chOA5HjLAvPcRDEM2KE5jr7Hfn_6GL4CTvbvJ7zDzBb4_6L-BNuDNgPsF31TwShgJ4Nf3q4Ao-QdXd6rPR9QzKko54CUpj0skm-Wg8qowKhXnYx"

    private init() {}
    
    private var yelpAuthHeaders: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(ApiHelper.YELP_API_KEY)" ]
        }
    }
    
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
}
