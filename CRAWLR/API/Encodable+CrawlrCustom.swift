//
//  Encodable+CrawlrCustom.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/23/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                 return dictionary
            }
        } catch {}
        return nil
    }
}
