//
//  NetworkError.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Foundation

/// Network error will be our default error type which will contain URLResponse and data returned from server.
public enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}
