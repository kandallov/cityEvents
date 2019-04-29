//
//  EventRoute.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/16/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation

public enum EventRoute: APIRoute {
    
    case getEvents(location: String, page: String)
    
    public var baseURL: String {
        return "https://www.eventbriteapi.com/"
    }
    
    public var token: String {
        return "L3YCIOR554K7WFMI6I6L"
    }
    
    public var path: String {
        switch self {
        case .getEvents:
            return "v3/events/search"
        }
    }
    
    public var params: [String: String] {
        switch self {
        case let .getEvents(location, page):
            return ["token": token, "location.address": location, "page": page]
        }
    }
}

