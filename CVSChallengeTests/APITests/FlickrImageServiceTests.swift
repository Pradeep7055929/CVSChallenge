//
//  FlickrImageServiceTests.swift
//  CVSChallengeTests
//
//  Created by Pradeep Kumar on 2/11/24.
//

import Combine
import XCTest
@testable import CVSChallenge

final class FlickrImageServiceTests: XCTestCase {
    
    
    private var cancellables: Set<AnyCancellable> = []
    
    func testGetFlickerImages() {
        let mockNetworking = MockRestAPIServiceProvider<Flickr>()
        let flickrImagesServiceProvider = FlickrImagesServiceProvider(networking: mockNetworking)
        
        let expect = expectation(description: "Testing Flickr images fetch")

        // 1) Given
        // Valid payload
        let searchTerm = "porcupine"
        let json = FileReader.jsonForFileName("Flickr")
        let jsonData = try? JSONSerialization.data(withJSONObject: json ?? [:], options: [])
        guard let data = jsonData else { return }
        let mockedFlikrData = try? JSONDecoder().decode(Flickr.self, from: data)
        guard let mockedFlikr = mockedFlikrData else { return }

        // Flickr images retrieval is attempted
        flickrImagesServiceProvider.getFlickrImagesData(searchString: searchTerm)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTAssertNil(error)
                    XCTFail("Flickr images fetch api failed")
                }
            } receiveValue: { flickrData in
                // 3) Then
                // Flickr image data is returned
                XCTAssertNotNil(flickrData)
                XCTAssertEqual(flickrData.images?.count, 20)
                expect.fulfill()
            }
            .store(in: &cancellables)
        // 2) When
        //   mock the responsee
        mockNetworking.response.send(mockedFlikr)
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testFlickrImagesFectNetworkError() {
        let mockNetworking = MockRestAPIServiceProvider<Flickr>()
        let flickrImagesServiceProvider = FlickrImagesServiceProvider(networking: mockNetworking)
        
        let expect = expectation(description: "Testing Flickr images fetch fail")
        // 1) Given
        let searchTerm = "porcupine"
        //   Flickr image data  retrieval is attempted
        flickrImagesServiceProvider.getFlickrImagesData(searchString: searchTerm)
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail("the fetch should not be successful")
                case .failure:
                    expect.fulfill()
                }
            } receiveValue: { _ in
                // 3) Then
                //    The response will contain an error of this kind
                XCTFail("the fetch should not emit flikr image details")
            }
            .store(in: &cancellables)
        // 2) When
        //    The server returns a fail response
        mockNetworking.response.send(completion: .failure(NetworkError.responseError))
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

