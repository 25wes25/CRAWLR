//
//  DataResponse+CrawlrCustom.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/22/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import Foundation
import Alamofire

extension DataResponse where Value == String {

    func translate<T>(to type: T.Type) -> T? where T: Decodable {
        var translated: T? = nil
        if let data = self.value?.data(using: .utf8) {
            do {
                translated = try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("translation failed")
            }
        }
        return translated
    }
}
