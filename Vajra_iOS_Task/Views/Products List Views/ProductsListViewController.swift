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
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Products"
        setUpTableView()
        viewModel.delegate = self
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setUpTableView() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func fetchProducts() {
        viewModel.getProducts()
    }
    
    @objc func refreshData() {
        fetchProducts()
    }
}

//MARK: -  UITableView ProductsListViewModelProtocol

extension ProductsListViewController: ProductsListViewModelProtocol {
    func didUpdateDataSource() {
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
            self.productsTableView.refreshControl?.endRefreshing()
        }
    }
}
