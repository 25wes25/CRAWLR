//
//  ApiResponses.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/22/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import Foundation

struct BusinessesResponse: Codable {
    var businesses: [Business]?
    var total: Int?
    var region: Region?
}
