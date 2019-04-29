//
//  APIRoute.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/14/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct APIRequestBody {
    var method: String
    var params: [String: Any]
}

public protocol APIRoute: URLRequestConvertible {
    var baseURL: String { get }
    var token: String { get }
    var path: String { get }
    var params: [String: String] { get }
}

public extension APIRoute {

    var baseURL: String {
        assertionFailure("Не установлен baseURL в реализации APIRoute")
        return ""
    }
    
    var token: String {
        return ""
    }

    var path: String {
        return ""
    }

    var params: [String: String] {
        return ["": ""]
    }

    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL)!.appendingPathComponent(path)
        var request = URLRequest(url: url)
        var components = URLComponents(string: url.absoluteString)
        let queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
        components?.queryItems = queryItems
        request.url = components!.url
        request.httpMethod = HTTPMethod.post.rawValue
        return request
    }
}
