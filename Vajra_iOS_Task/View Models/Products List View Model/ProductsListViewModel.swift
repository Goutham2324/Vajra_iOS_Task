//
//  ProductsListViewModel.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation

protocol ProductsListViewModelProtocol: AnyObject {
    func didUpdateDataSource()
}

class ProductsListViewModel {
    
    let networkService = NetworkService()
    
    weak var delegate: ProductsListViewModelProtocol?
    
    private(set) var productsData: [Products] = []
    
    func getProducts() {
        networkService.getProductsData { [weak self] result in
            switch result {
            case .success(let products):
                self?.productsData = products
                self?.delegate?.didUpdateDataSource()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
