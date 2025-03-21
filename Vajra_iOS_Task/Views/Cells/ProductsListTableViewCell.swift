//
//  ProductsListTableViewCell.swift
//  Vajra_iOS_Task
//
//  Created by Swejan Kothamasu on 08/11/24.
//

import Foundation
import UIKit

class ProductsListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    
    private let viewModel = ProductsListViewModel()
    
    func populateCell(for model: Products) {
        productTitleLabel.textAlignment = .center
        productTitleLabel.numberOfLines = 0
        productTitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        
        productImageView.contentMode = .scaleAspectFill
        
        productImageView.image = UIImage(named: "dummy_produt")
        
        viewModel.imageCacheService.loadImage(from: model.image.src) { image in
            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }
        productTitleLabel.text = model.title
        
    }
    
}
