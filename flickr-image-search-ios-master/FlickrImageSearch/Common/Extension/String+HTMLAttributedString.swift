//
//  String+HTMLAttributedString.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import Foundation

extension String {
    func convertHTMLToAttributedString(completion: @escaping (AttributedString) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = self.data(using: .utf8) else {
                DispatchQueue.main.async {
                    completion(AttributedString())
                }
                return
            }

            if let attributedString = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil) {
                
                let attributedString = AttributedString(attributedString)
                DispatchQueue.main.async {
                    completion(attributedString)
                }
            } else {
                DispatchQueue.main.async {
                    completion(AttributedString())
                }
            }
        }
    }
}
