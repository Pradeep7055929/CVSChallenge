//
//  MockRestAPIServiceProvider.swift
//  APIServiceProvider.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Combine
import Foundation

public class MockRestAPIServiceProvider<D: Decodable>: APIService {
    
    public init() { }

    public var response = PassthroughSubject<D, NetworkError>()

    public func decodableRequest<D: Decodable>(searchString: String?,
                                               decodableType: D.Type) -> AnyPublisher<D, NetworkError> {
        response.eraseToAnyPublisher() as! AnyPublisher<D, NetworkError>
    }
}
