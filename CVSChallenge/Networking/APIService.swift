//
//  APIService.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//


import Combine
import Foundation

/// NetworkingType representings the set of methods that a network layer must contain,
/// Itt also includes the default implementation of these methods..The Networking Layer should override these implementation Only if their use case is not met in the implementation.
public protocol APIService: AnyObject {

    var urlSession: URLSession { get }

    // MARK: - Requests
    /// Returns a raw data task publisher for the given request, use this to perform any custom operations.
    /// - Parameter type: URL
    func rawRequest(url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>

    /// Returns a decoded stream of response data if sucessfull.
    /// - Parameters:
    ///   - type: String.
    ///   - decodableType: Type of expected response.
    func decodableRequest<D: Decodable>(searchString: String?, decodableType: D.Type) -> AnyPublisher<D, NetworkError>
}

extension APIService {

    public var urlSession: URLSession {
        URLSession.shared
    }

    /// This method gives the Raw response as returned from URLSession Data task.
    /// - Parameter type: URL
    /// - Returns: AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
    public  func rawRequest(url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return self
            .urlSession
            .dataTaskPublisher(for: url)
            .map { data, response -> (Data, URLResponse) in
                return (data, response)
            }
            .eraseToAnyPublisher()
    }

    public func decodableRequest<D: Decodable>(searchString: String?, decodableType: D.Type) -> AnyPublisher<D, NetworkError> {
        guard let url = URL(string: Endpoint.baseURL.appending(searchString == nil ? "" : "\(searchString ?? "")")) else {
            return AnyPublisher(Fail<D, NetworkError>(error: NetworkError.invalidURL))
        }
        print("URL is \(url.absoluteString)")
        return self.rawRequest(url: url)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }
                return data
            })
            .decode(type: decodableType, decoder: JSONDecoder())
            .mapError({ error in
                if let error = error as? NetworkError {
                    return error
                } else {
                    return NetworkError.unknown
                }
            })
            .eraseToAnyPublisher()
    }
}

