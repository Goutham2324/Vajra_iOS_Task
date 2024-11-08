//
//  ProductsListViewController.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation
import UIKit

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    
    let viewModel = ProductsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        viewModel.delegate = self
        viewModel.getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUpTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
}

//MARK: -  UITableView ProductsListViewModelProtocol

extension ProductsListViewController: ProductsListViewModelProtocol {
    func didUpdateDataSource() {
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
}
