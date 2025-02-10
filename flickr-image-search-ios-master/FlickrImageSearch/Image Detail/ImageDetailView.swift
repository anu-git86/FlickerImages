//
//  ImageDetailView.swift
//  FlickrImageSearch
//
//  Created by Anusha Gattamaneni on 2/10/25.
//

import SwiftUI

struct ImageDetailView: View {
    @State private var isShareSheetShowing: Bool = false
    @State private var attributedDescription: AttributedString = AttributedString("")
    
    let flickrImage: FlickrImage
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                AsyncImage(url: URL(string: flickrImage.media?.m ?? ""))
                    .aspectRatio(contentMode: .fit)
                    .accessibilityLabel("Image: \(flickrImage.title ?? "No Image")")
                Text(flickrImage.title ?? "No Title")
                    .bold()
                    .font(.headline)
                Text(attributedDescription)
                    .font(.body)
                    .onAppear {
                        flickrImage.description?.convertHTMLToAttributedString { attributedString in
                            self.attributedDescription = attributedString
                        }
                    }
                Text("Author: \(flickrImage.author?.formatAuthor() ?? "Unknown")")
                    .font(.subheadline)
                Text("Published: \(flickrImage.published?.formatDate() ?? "Unknown")")
                    .font(.footnote)
                let dimensions = (flickrImage.description ?? "").extractImageDimensions()
                Text("Width: \(dimensions.width) pixels, Height: \(dimensions.height) pixels")
                    .font(.footnote)
                Button(action: { self.isShareSheetShowing = true }) {
                    Text("Share")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                }.accessibilityHint("Opens a share view to share image and information about the image")
                .padding()
                .sheet(isPresented: $isShareSheetShowing) {
                    if let shareURL = URL(string: flickrImage.media?.m ?? "") {
                        ShareSheetView(items: [shareURL, flickrImage.title ?? "No title"]) // TODO: include image and metadata
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle(Text(flickrImage.title ?? "No Title"), displayMode: .inline)
        .accessibilityElement(children: .combine)
    }
}
