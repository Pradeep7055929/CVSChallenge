//
//  LocalDataProvider.swift
//  CVSChallenge
//
//  Created by Ashok Mango on 2/11/24.
//

import Foundation

/// This class provides the data from local json
class LocalDataProvider {
    static func getJsonDataFromLocal() -> [ImageData] {
        guard let filePath = Bundle(for: self).path(forResource: "Flickr", ofType: "json"),
            let data = NSData(contentsOfFile: filePath),
            let mockedFlikrData = try? JSONDecoder().decode(Flickr.self, from: data as Data),
            let images = mockedFlikrData.images else {
                return [ImageData]()
        }
        print(images)
        return images
    }
}
