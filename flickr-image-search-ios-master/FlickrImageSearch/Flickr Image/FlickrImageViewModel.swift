//
//  FlickrImageViewModel.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import Foundation

import SwiftUI

class FlickrImageViewModel: ObservableObject {
    @Published var images: [FlickrImage] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    private var flickrService: FlickrImageService = FlickrImageService()

    func fetchImages() {
        guard !searchText.isEmpty else {
            images = [] // Clear images if search text is empty
            isLoading = false
            return
        }
        
        isLoading = true
        flickrService.fetchImages(searchText: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self?.images = images
                case .failure(let error):
                    print(error)
                    self?.images = []
                }
                self?.isLoading = false
            }
        }
    }
}
