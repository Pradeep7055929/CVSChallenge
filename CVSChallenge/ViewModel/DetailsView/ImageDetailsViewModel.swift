//
//  ImageDetailsViewModel.swift
//  CVSChallenge
//
//  Created by Pradeep Kumar on 2/11/24.
//

import Foundation

/// Concrete implementation of the Image details view model
class ImageDetailsViewModel {
    
    // MARK: - Properties

    var imageData: ImageData
    
    // Displays Image
    var imageUrl: String? {
        self.imageData.media?.url ?? ""
    }
    
    // Header title
    var title: String {
        "\(self.imageData.title ?? "")"
    }
    
    // Displays description
    var description: String {
        let descriptionString = self.convertHTMLIntoString(htmlString: self.imageData.description ?? "")
        return "\(descriptionString)"
    }
    
    // Displays author
    var author: String {
        "\(self.imageData.author ?? "")"
    }
    
    // Published date
    var publishedDate: String {
        let pubDate = self.getPublishedDate(dateString: self.imageData.published ?? "")
        return pubDate ?? ""
    }
    
    // MARK: - Initializer
    init(imageData: ImageData) {
        self.imageData = imageData
    }
    
    // MARK: - Methods

    func convertHTMLIntoString(htmlString: String) -> NSAttributedString {
        
        var descriptionAttributedString = NSAttributedString()
        
        let data = Data(htmlString.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            descriptionAttributedString = attributedString
        }
        
        return descriptionAttributedString
    }
    
    /// Formatted published date
    func getPublishedDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString)  else {
            return nil
        }
        dateFormatter.dateFormat = "MMM d YY"
        return dateFormatter.string(from: date)
    }
}
