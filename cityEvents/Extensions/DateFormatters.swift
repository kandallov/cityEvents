//
//  DateFormatters.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/20/18.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit

protocol DateFormatterProtocol {
    var dateFormatter: DateFormatter { get }
}

enum DateformatterType: String, DateFormatterProtocol {
    
    case `default` = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    case EEEEMMMMddHHmm = "EEEE, MMMM dd, HH:mm"
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter.init(withFormat: self.rawValue, locale: "en-US")
        formatter.timeZone = .current
        return formatter
    }
}

extension Date {
    
    static func fromString(_ string: String, _ type: DateformatterType) -> Date? {
        return type.dateFormatter.date(from: string)
    }
}

extension String {
    
    static func fromDate(_ date: Date, _ type: DateformatterType) -> String {
        return type.dateFormatter.string(from: date)
    }
}
