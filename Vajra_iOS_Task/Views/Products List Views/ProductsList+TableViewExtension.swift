//
//  ProductsList+TableViewExtension.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation
import UIKit

//MARK: -  UITableView datasource method

extension ProductsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell") as? ProductsListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.populateCell(for: viewModel.productsData[indexPath.row])
        
        return cell
    }

}

//MARK: -  UITableView delegate method

extension ProductsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
