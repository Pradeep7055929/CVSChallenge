//
//  ImageDetailsViewModelTest.swift
//  CVSChallengeTests
//
//  Created by Pradeep Kumar on 2/11/24.
//

import Combine
import XCTest
@testable import CVSChallenge

final class ImageDetailsViewModelTests: XCTestCase {

    func testImageTitle() {
        // 1) Given
        // Valid payload
        guard let flikrModel = self.getFlikrModel() else {
            XCTFail("Failed")
            return
        }
        
        // 2) When
        guard let imageData = flikrModel.images?[0] else {
            XCTFail("Failed")
            return
        }
        let viewModel = ImageDetailsViewModel(imageData: imageData)
        
        // 3) Then
        XCTAssertEqual(flikrModel.images?[0].title, viewModel.title)
    }
    
    func testImageAuthor() {
        // 1) Given
        // Valid payload
        guard let flikrModel = self.getFlikrModel() else {
            XCTFail("Failed")
            return
        }
        
        // 2) When
        guard let imageData = flikrModel.images?[0] else {
            XCTFail("Failed")
            return
        }
        let viewModel = ImageDetailsViewModel(imageData: imageData)
        
        // 3) Then
        XCTAssertEqual(flikrModel.images?[0].author, viewModel.author)
    }
    
    func testImagePublishedDate() {
        // 1) Given
        // Valid payload
        guard let flikrModel = self.getFlikrModel() else {
            XCTFail("Failed")
            return
        }
        
        // 2) When
        guard let imageData = flikrModel.images?[0] else {
            XCTFail("Failed")
            return
        }
        let viewModel = ImageDetailsViewModel(imageData: imageData)
        
        // 3) Then
        XCTAssertEqual("Feb 10 24", viewModel.publishedDate)
    }
    
    // Get Flickr model
    func getFlikrModel() -> Flickr? {
        let json = FileReader.jsonForFileName("Flickr")
        let jsonData = try? JSONSerialization.data(withJSONObject: json ?? [:], options: [])
        guard let data = jsonData else { return nil }
        let mockedFlikrData = try? JSONDecoder().decode(Flickr.self, from: data)
        guard let mockedFlikr = mockedFlikrData else { return nil }
        return mockedFlikr
    }
}
