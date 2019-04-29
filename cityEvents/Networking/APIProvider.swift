//
//  APIDomain.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/14/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON
import Alamofire

public protocol APIProviderProtocol {

    associatedtype TRoute

    func request(_ route: TRoute, onCompletion: @escaping (_ json: JSON?, _ error: Error?) -> Void) -> Request
}

public class APIProvider<Route: APIRoute>: APIProviderProtocol {

    public typealias TRoute = Route

    private let sessionManager: Alamofire.SessionManager
    private let apiSessionDelegate = APISessionDelegate()

    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 90
        sessionManager = Alamofire.SessionManager(
            configuration: configuration,
            delegate: apiSessionDelegate,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: [:])
        )
    }

    @discardableResult public func request(_ route: Route, onCompletion: @escaping (_ json: JSON?, _ error: Error?) -> Void) -> Request {
        return sessionManager.request(route).validate().responseJSON { response -> Void in
            let (json, error) = self.handle(response)
            onCompletion(json, error)
        }
    }

    private func handle(_ response: DataResponse<Any>) -> (json: JSON?, error: Error?) {

        switch response.result {

        case .success(let value):
            return (JSON(value), nil)

        case .failure(let error):
            return (nil, error)

        }
    }
}
