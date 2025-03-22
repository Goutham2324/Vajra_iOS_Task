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
        let product = viewModel.productsData[indexPath.row]
        
        let imageWidth = CGFloat(product.image.width)
        let imageHeight = CGFloat(product.image.height)
        
        guard imageWidth > 0 else { return 100 } // Default height in case of zero width
        
        let aspectRatio = imageHeight / imageWidth
        let calculatedHeight = tableView.frame.width * aspectRatio
        return calculatedHeight + 30 // Add padding for other UI elements
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsListTableViewCell") as? ProductsListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.populateCell(for: viewModel.productsData[indexPath.row])
        
        cell.selectionStyle = .none
        
        return cell
    }

}

//MARK: -  UITableView delegate method

extension ProductsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let webVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailsWebViewController") as? ProductDetailsWebViewController {
            webVC.bodyHTML = viewModel.productsData[indexPath.row].bodyHTML
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}
