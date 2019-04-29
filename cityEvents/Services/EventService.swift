//
//  EventService.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/16/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

protocol EventServiceProtocol {
    func getEvents(with location: String, page: String) -> Observable<EventBrite>
}

class EventService: EventServiceProtocol {
    struct Dependency {
        let api: APIProvider<EventRoute>
    }
    
    let dp: Dependency
    
    init(dp: Dependency) {
        self.dp = dp
    }
    
    func getEvents(with location: String, page: String) -> Observable<EventBrite> {
        return dp.api.rxRequestItem(.getEvents(location: location, page: page))
    }
}
