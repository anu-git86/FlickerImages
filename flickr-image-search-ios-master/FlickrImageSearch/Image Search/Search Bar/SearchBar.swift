//
//  SearchBar.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar: UISearchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator // TODO: create coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

extension SearchBar: SearchBarCoordinator {
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
}
