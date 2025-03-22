//
//  ProductsListViewModel.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation
import UIKit

protocol ProductsListViewModelProtocol: AnyObject {
    func didUpdateDataSource()
}

class ProductsListViewModel {

    let networkService = NetworkService()
    let imageCacheService = ImageCacheService()
    weak var delegate: ProductsListViewModelProtocol?

    private(set) var productsData: [Products] = []

    func getProducts() {
        networkService.getProductsData { [weak self] result in
            switch result {
            case .success(let products):
                self?.productsData = products
                CoreDataManager.shared.saveProducts(products)
            case .failure(let error):
                print("Network request failed: \(error.localizedDescription)")
                self?.productsData = CoreDataManager.shared.fetchProducts()
            }
            self?.delegate?.didUpdateDataSource()
        }
    }


    private func loadFromCoreData() {
        self.productsData = CoreDataManager.shared.fetchProducts()
        self.delegate?.didUpdateDataSource()
    }
}
