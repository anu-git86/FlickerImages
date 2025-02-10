//
//  FlickrImage.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import Foundation

struct FlickrImage: Identifiable {
    let id: UUID = UUID()
    let title: String?
    let link: String?
    let media: Media?
    let dateTaken: String?
    let description: String?
    let published: String?
    let author: String?
}

extension FlickrImage: Decodable {
    enum CodingKeys: String, CodingKey {
        case title, link, media, description, published, author
        case dateTaken = "date_taken"
    }
}

extension FlickrImage: Hashable {
    static func == (lhs: FlickrImage, rhs: FlickrImage) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
    }
}

struct Media: Decodable {
    let m: String?
}
