//
//  CachedAsyncImage.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    private let loader = ImageLoader()
    let url: String
    let content: (Image) -> Content
    let placeholder: () -> Placeholder

    init(url: String, @ViewBuilder content: @escaping (Image) -> Content, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if let image = loader.image {
                content(Image(uiImage: image))
            } else {
                placeholder()
            }
        }
        .task {
           await loader.loadImage(urlString: url)
        }
    }
}
