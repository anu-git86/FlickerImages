//
//  FlickrImageFeed.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import Foundation

struct FlickrImageFeed: Decodable {
    let title: String?
    let link: String?
    let description: String?
    let modified: String?
    let generator: String?
    let items: [FlickrImage]?
}
