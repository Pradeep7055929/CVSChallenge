//
//  FileReader.swift
//  
//
//  Created by Pradeep Kumar on 2/11/24.
//

import Foundation

class FileReader {
    static func jsonForFileName(_ name: String, forClass bundleClass: AnyClass = FileReader.self) -> Any? {
        guard let filePath = Bundle(for: self).path(forResource: name, ofType: "json"),
            let data = NSData(contentsOfFile: filePath),
            let json = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) else {
                return nil
        }
        return json
    }
}
