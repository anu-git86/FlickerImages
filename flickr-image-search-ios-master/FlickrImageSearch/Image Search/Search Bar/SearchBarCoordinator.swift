//
//  SearchBarCoordinator.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import SwiftUI

protocol SearchBarCoordinator {
    func makeCoordinator() -> Coordinator
}

class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
        _text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
    }
}
