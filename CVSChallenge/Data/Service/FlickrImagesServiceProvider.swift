//
//  FlickrImagesServiceProvider.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Combine
import Foundation

/// A service provider for fetching data from the FlickrImagesService API.
final public class FlickrImagesServiceProvider: FlickrImagesService {

    /// The networking service used to make API requests.
    public var networking: APIService

    /// Initializes an instance of FlickrImagesServiceProvider.
    /// - Parameter networking: An optional networking service. Defaults to `APIServiceProvider()`.
    init(networking: APIService = APIServiceProvider()) {
        self.networking = networking
    }

    /// Fetches Flickr Images Data  from the FlickrImagesService API.
    /// - Returns: A publisher that emits an instance of `FlickrImagesService` or an error of type `NetworkError`.
    public func getFlickrImagesData(searchString: String?) -> AnyPublisher<Flickr, NetworkError> {
        self.networking
            .decodableRequest(searchString: searchString, decodableType: Flickr.self)
            .eraseToAnyPublisher()
    }
    
    /// Fetches Flickr Images Data  from the FlickrImagesService API.
    /// - Returns: A publisher that emits an instance of `FlickrImagesService` or an error of type `NetworkError`.
    public func getImageFromUrl(url: URL) ->  AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        self.networking
            .rawRequest(url: url)
            .eraseToAnyPublisher()
    }
}
