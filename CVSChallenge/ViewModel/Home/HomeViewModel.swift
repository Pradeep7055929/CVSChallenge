//
//  HomeViewModel.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Combine
import Foundation

/// Concrete implementation of the Home view model
class HomeViewModel: HomeViewModelType {

    // MARK: - Properties
    var input: HomeViewModelInputType {
        self
    }
    var output: HomeViewModelOutputType {
        self
    }
    private let isLoadingSubject: CurrentValueSubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false)
    var isLoading: AnyPublisher<Bool, Never> {
        self.isLoadingSubject.eraseToAnyPublisher()
    }
    private var serviceProvider: FlickrImagesService
    private var cancelable: Set<AnyCancellable> = []
    @Published var images: [ImageData]?

    // MARK: - Initializers

    init(serviceProvider:  FlickrImagesService = FlickrImagesServiceProvider()) {
        self.serviceProvider = serviceProvider
    }
}

// MARK: - Api calls

extension HomeViewModel {
    func fetchImages(searchString: String) {
        self.isLoadingSubject.send(true)
        self.serviceProvider
            .getFlickrImagesData(searchString: searchString)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                // Loads data from local
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.images = LocalDataProvider.getJsonDataFromLocal()
                    self?.isLoadingSubject.send(false)
                }
            } receiveValue: { [weak self] flickrImagesData in
                guard let images = flickrImagesData.images else {
                    return
                }
                
                self?.images = images
            }
            .store(in: &self.cancelable)
    }
}
