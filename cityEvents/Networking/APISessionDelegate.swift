//
//  APISessionDelegate.swift
//  cityEvents
//
//  Created by Aleksandr Kandalov on 3/14/19.
//  Copyright © 2019 Aleksandr Kandalov. All rights reserved.
//

import UIKit
import Alamofire

class APISessionDelegate: SessionDelegate {

    override init() {
        super.init()

        sessionDidReceiveChallengeWithCompletion = { session, challenge, completion in
            guard let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0 else {
                completion(.cancelAuthenticationChallenge, nil)
                return
            }

            let rootIdx = SecTrustGetCertificateCount(trust) - 1

            if let serverCertificate = SecTrustGetCertificateAtIndex(trust, rootIdx), let serverCertificateKey = APISessionDelegate.publicKey(for: serverCertificate) {
                if APISessionDelegate.pinnedKeys().contains(serverCertificateKey) {
                    completion(.useCredential, URLCredential(trust: trust))
                    return
                }
            }

            completion(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
    }

    private static func pinnedCertificates() -> [Data] {
        var certificates: [Data] = []

        if let pinnedCertificateURL = Bundle.main.url(forResource: "level1", withExtension: "der") {
            do {
                let pinnedCertificateData = try Data(contentsOf: pinnedCertificateURL)
                certificates.append(pinnedCertificateData)
            } catch _ {
                // Handle error
            }
        }

        return certificates
    }

    private static func pinnedKeys() -> [SecKey] {
        var publicKeys: [SecKey] = []

        if let pinnedCertificateURL = Bundle.main.url(forResource: "level1", withExtension: "der") {
            if let pinnedCertificateData = NSData.init(contentsOfFile: pinnedCertificateURL.path) {
                if let pinnedCertificate = SecCertificateCreateWithData(nil, pinnedCertificateData) {
                    if let key = publicKey(for: pinnedCertificate) {
                        publicKeys.append(key)
                    }
                }
            }
        }

        return publicKeys
    }

    // Implementation from Alamofire
    private static func publicKey(for certificate: SecCertificate) -> SecKey? {
        var publicKey: SecKey?

        let policy = SecPolicyCreateBasicX509()
        var trust: SecTrust?
        let trustCreationStatus = SecTrustCreateWithCertificates(certificate, policy, &trust)

        if let trust = trust, trustCreationStatus == errSecSuccess {
            publicKey = SecTrustCopyPublicKey(trust)
        }

        return publicKey
    }
}
