//
//  NetworkService.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation

class NetworkService {
    
    private let serviceURL: String = "https://run.mocky.io/v3/bc60eb35-f1a1-415f-8310-7f1fcfb32459"
    
    func getProductsData(completion: @escaping (Result<[Products], Error>) -> Void) {
        let request = URLRequest(url: URL(string: serviceURL)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "NetworkServiceError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
                return
            }
            do {
                let result = try JSONDecoder().decode(Article.self, from: data)
                completion(.success(result.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
