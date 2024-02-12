//
//  ImageViewModel.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/10/24.
//

import Combine
import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var image: UIImage?

    private var serviceProvider: FlickrImagesService = FlickrImagesServiceProvider()
    private var imageCache: NSCache<NSString, UIImage>?
    private var cancelable: Set<AnyCancellable> = []

    init(urlString: String?) {
        loadImage(urlString: urlString)
    }

    private func loadImage(urlString: String?) {
        guard let urlString = urlString else { return }

        if let imageFromCache = getImageFromCache(from: urlString) {
            self.image = imageFromCache
            return
        }

        loadImageFromURL(urlString: urlString)
    }

    private func loadImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        self.serviceProvider
            .getImageFromUrl(url: url)
            .receive(on: DispatchQueue.main)
            .sink { error in
                // Handle Error
            } receiveValue: { [weak self] (data, response) in
                DispatchQueue.main.async { [weak self] in
                    guard let loadedImage = UIImage(data: data) else { return }
                    self?.image = loadedImage
                    self?.setImageCache(image: loadedImage, key: urlString)
                }
            }
            .store(in: &self.cancelable)
    }

    private func setImageCache(image: UIImage, key: String) {
        imageCache?.setObject(image, forKey: key as NSString)
    }

    private func getImageFromCache(from key: String) -> UIImage? {
        return imageCache?.object(forKey: key as NSString)
    }
}
