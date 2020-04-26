//
//  ApiModels.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/22/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import Foundation

struct Center: Codable {
    var longitude: Double?
    var latitude: Double?
}

struct Region: Codable {
    var center: Center?
}

struct Category: Codable {
    var alias: String?
    var title: String?
}

struct Location: Codable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zip_code: String?
    var country: String?
    var state: String?
    var display_address: [String]?
}

struct HoursOpen: Codable {
    var is_overnight: Bool?
    var start: String?
    var end: String?
    var day: Int
}

struct BusinessHours: Codable {
    var open: [HoursOpen]?
    var hours_type: String?
    var is_open_now: Bool?
}

struct Business: Codable {
    var id: String?
    var alias: String?
    var name: String?
    var image_url: String?
    var is_closed: Bool?
    var url: String?
    var review_count: Int?
    var categories: [Category]?
    var rating: Double?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var display_phone: String?
    var distance: Double?
    var hours: [BusinessHours]?
    var photos: [String]?
}
