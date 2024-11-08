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
    
    func populateCell(for model: Products) {
        productTitleLabel.textAlignment = .center
        productTitleLabel.numberOfLines = 0
        
        productImageView.image = UIImage(named: "dummy_produt")
        productTitleLabel.text = model.title
    }
    
}
