//
//  EventBrite.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/16/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import ObjectMapper

struct EventBrite: Mappable {
    var pagination: Pagination?
    var events: [Event]?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        pagination <- map["pagination"]
        events <- map["events"]
    }
}

struct Pagination: Mappable {
    var pageCount: Int?
    var pageNumber: Int?
    var hasMoreItems: Bool?
    var objectCount: Int?
    var pageSize: Int?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        pageCount <- map["page_count"]
        pageNumber <- map["page_number"]
        hasMoreItems <- map["has_more_items"]
        objectCount <- map["object_count"]
        pageSize <- map["page_size"]
    }
}

struct Event: Mappable {
    var id: String?
    var venueId: String?
    var locale: String?
    var published: String?
    var summary: String?
    var isFree: Bool?
    var start: Date?
    var end: Date?
    var name: String?
    var description: String?
    var logoUrl: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        venueId <- map["venue_id"]
        locale <- map["locale"]
        published <- map["published"]
        summary <- map["summary"]
        isFree <- map["is_free"]
        start <- (map["start.local"], DateFormatterTransform(dateFormatter: DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss", locale: "en_US")))
        end <- (map["end.local"], DateFormatterTransform(dateFormatter: DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss", locale: "en_US")))
        name <- map["name.text"]
        description <- map["description.text"]
        logoUrl <- map["logo.url"]
    }
}
