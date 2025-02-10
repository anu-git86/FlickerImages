//
//  FlickrImageService.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import Foundation

class FlickrImageService {
    func fetchImages(searchText: String, completion: @escaping (Result<[FlickrImage], Error>) -> ()) {
        let baseUrl: String = "https://api.flickr.com/services/feeds/photos_public.gne"
        let queryItems: [URLQueryItem] = [URLQueryItem(name: "format", value: "json"),
                                          URLQueryItem(name: "nojsoncallback", value: "1"),
                                          URLQueryItem(name: "tags", value: searchText)]
        var urlComponents: URLComponents = URLComponents(string: baseUrl)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let feed = try JSONDecoder().decode(FlickrImageFeed.self, from: data)
                DispatchQueue.main.async {
                    guard let items = feed.items else { return }
                    completion(.success(items))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
