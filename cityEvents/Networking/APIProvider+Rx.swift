//
//  APIProvider+Rx.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/14/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import ObjectMapper

extension APIProvider {
    
    public func rxRequestItem<T: Mappable>(_ route: Route, responseKey: String? = nil) -> Observable<T> {
        return rxRequest(route).map({ (json) in
            if let result = Mapper<T>().map(JSONObject: json.rawValue) {
                return result
            }

            throw NSError(domain: "parser", code: -2, userInfo: [NSLocalizedDescriptionKey: "Parsing error"])
        })
    }

    public func rxRequestItems<T: Mappable>(_ route: Route, responseKey: String? = nil) -> Observable<[T]> {
        return rxRequest(route).map({ (json) in
            if let result = Mapper<T>().mapArray(JSONObject: json.rawValue) {
                return result
            }

            throw NSError(domain: "parser", code: -2, userInfo: [NSLocalizedDescriptionKey: "Parsing error"])
        })
    }

    public func rxRequest(_ route: Route) -> Observable<JSON> {
        let signal: PublishSubject<JSON> = PublishSubject()

        request(route) { (json, error) in
            if json != nil {
                signal.onNext(json!)
            } else if error != nil {
                signal.onError(error!)
            } else {
                signal.onError( NSError(domain: "APIProvider", code: -1, userInfo: [:]) )
            }
        }

        return signal
    }
}
