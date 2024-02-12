//
//  HomeViewModelOutputType.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/11/24.
//

import Combine
import Foundation

/// Protocol with input into  the view model
public protocol HomeViewModelInputType {
    
    // Publisher that fires when the model requests to call an API
    var isLoading: AnyPublisher<Bool, Never> { get }
    
    /// Property to hold images data
    var images: [ImageData]? { get }
}

/// Protocol with outputs coming from the view model
public protocol HomeViewModelOutputType {
    
    /// Fetch image from API
    func fetchImages(searchString: String)
}

/// Protocol with main data to adopt in HomeView
public protocol HomeViewModelType: ObservableObject, HomeViewModelInputType, HomeViewModelOutputType {
    
    /// Input handler
    var input: HomeViewModelInputType { get }
    /// Output handler
    var output: HomeViewModelOutputType { get }
}
