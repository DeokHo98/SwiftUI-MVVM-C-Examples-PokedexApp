//
//  ImageLoader.swift
//  PokemonDex-MVVM
//
//  Created by Jeong Deokho on 9/10/24.
//

import UIKit

@Observable
final class ImageLoader {
    var image: UIImage?
    private static let imageCache = NSCache<NSString, UIImage>()

    /// Loads an image from the given URL string. Uses cached image if available.
    func loadImage(urlString: String) async {
        if let cachedImage = Self.imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        await fetchImage(urlString: urlString)
    }
    
    /// Fetches an image from the given URL string and updates the image property.
    private func fetchImage(urlString: String) async {
        guard let url = URL(string: urlString) else { return }
        let loadedImage = await fetchImage(url: url)
        guard let loadedImage else { return }
        self.image = loadedImage
        Self.imageCache.setObject(loadedImage, forKey: urlString as NSString)
    }
    
    /// Fetches an image from the given URL.
    private func fetchImage(url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            return image
        } catch {
            return nil
        }
    }
}
