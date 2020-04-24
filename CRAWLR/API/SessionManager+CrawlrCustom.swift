//
//  SessionManager+CrawlrCustom.swift
//  CRAWLR
//
//  Created by Wesley Swanson on 4/23/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import Alamofire

extension SessionManager {

    func request(_ url: URLConvertible, _ method: HTTPMethod, _ parameters: Parameters?, urlParameterEncoding: Bool = false) -> DataRequest {
        let defaultHeaders: HTTPHeaders = ["Content-Type": "application/json"]
        if urlParameterEncoding {
            let urlEncoding = URLEncoding(destination: .queryString, arrayEncoding: .brackets, boolEncoding: .literal)
            return self.request(url, method: method, parameters: parameters, encoding: urlEncoding, headers: defaultHeaders)
        } else {
            return self.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders)
        }
    }
}
