//
//  FlickrImagesService.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Combine
import Foundation

/// FlickrImagesService represents the method required for retrieving `Flickr` images data.
public protocol FlickrImagesService {

    // MARK: - Properties

    var networking: APIService { get set }

    // MARK: - Methods
    /// Retrieves images data from the Flickr API.
    /// - Returns: A publisher that emits an instance of `Flickr` or an error of type `NetworkError`.
    func getFlickrImagesData(searchString: String?) -> AnyPublisher<Flickr, NetworkError>
    
    // MARK: - Methods
    /// Retrieves images data from the Flickr API.
    /// - Returns: A publisher that emits an instance of `success` or an error of type `error`.
    func getImageFromUrl(url: URL) ->  AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>

}
