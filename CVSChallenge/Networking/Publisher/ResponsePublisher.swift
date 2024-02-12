//
//  ResponsePublisher.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Combine
import Foundation

public class ResponsePublisher {

    public static let shared = ResponsePublisher()

    /// Subject to publish an invalid url
    var invalidUrlSubject = PassthroughSubject<Void, Never>()

    /// Publishes an invalid url
    public var invalidUrl: AnyPublisher<Void, Never> {
        self.invalidUrlSubject.eraseToAnyPublisher()
    }
}
