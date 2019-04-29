//
//  ApiConfig.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/14/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import Foundation

// MARK: - Base protocol
public protocol APIConfigProtocol {
    var baseURL: String { get }
}

public struct APIConfig {

    public static var shared: APIConfigProtocol?

    static var safeShared: APIConfigProtocol {
        guard let config = shared else {
            assertionFailure("Установите конфиг для Network слоя в AppDelegate")
            return shared!
        }
        return config
    }

}
