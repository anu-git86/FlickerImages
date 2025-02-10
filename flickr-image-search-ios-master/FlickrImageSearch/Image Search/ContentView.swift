//
//  ContentView.swift
//  FlickrImageSearch
//
// Created by Anusha Gattamaneni on 2/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: FlickrImageViewModel = FlickrImageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView()
                                .accessibilityLabel("Loading image")
                        }
                    }
                    .padding()
                ImageGridView(images: viewModel.images)
            }
            .navigationBarTitle("Flickr Image Search")
        }
        .onChange(of: viewModel.searchText) {
            viewModel.fetchImages() // Trigger image fetching when search text changes
        }
    }
}

#Preview {
    ContentView()
}
