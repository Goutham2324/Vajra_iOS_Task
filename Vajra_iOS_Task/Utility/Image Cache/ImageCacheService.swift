//
//  ImageCacheService.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation
import UIKit

class ImageCacheService {
    
    private let fileManager = FileManager.default

    private func imagePath(for id: Int) -> URL? {
        guard let documentsDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent("\(id).png")
    }
    // the same method takes care of saving and loading the image from file systems
    func loadImage(for id: Int, from urlString: String, completion: @escaping (Int, UIImage?) -> Void) {
        if let localPath = imagePath(for: id), fileManager.fileExists(atPath: localPath.path) {
            let image = UIImage(contentsOfFile: localPath.path)
            completion(id, image)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(id, nil)
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                completion(id, nil)
                return
            }

            if let localPath = self.imagePath(for: id) {
                try? data.write(to: localPath) // Cache the image locally
            }

            completion(id, image)
        }.resume()
    }
}
