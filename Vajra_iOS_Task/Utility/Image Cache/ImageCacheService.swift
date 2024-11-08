//
//  ImageCacheService.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation
import UIKit

class ImageCacheService {
    private let cache = NSCache<NSString, UIImage>()
    
    // Retrieve image from cache if it exists, otherwise download it
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        // Check if image is already cached
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        // Download image if not in cache
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            
            // Cache the image after downloading
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }
}
