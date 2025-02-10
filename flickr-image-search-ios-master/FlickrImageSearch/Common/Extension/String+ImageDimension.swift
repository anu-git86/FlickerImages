//
//  String+ImageDimension.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import Foundation

extension String {
    func extractImageDimensions() -> (width: String, height: String) {
        // Example regex pattern to find width and height (adjust based on actual HTML structure)
        let pattern = "width=\"(\\d+)\".*height=\"(\\d+)\""
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators) {
            let nsrange = NSRange(self.startIndex..<self.endIndex, in: self)
            if let match = regex.firstMatch(in: self, options: [], range: nsrange) {
                let widthRange = Range(match.range(at: 1), in: self)
                let heightRange = Range(match.range(at: 2), in: self)
                
                let width = widthRange.map { String(self[$0]) } ?? "Unknown"
                let height = heightRange.map { String(self[$0]) } ?? "Unknown"
                
                return (width, height)
            }
        }
        
        return ("Unknown", "Unknown")
    }
}
