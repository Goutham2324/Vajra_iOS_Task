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
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    private let viewModel = ProductsListViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        // Configure Title Label
        productTitleLabel.textAlignment = .center
        productTitleLabel.numberOfLines = 0
        productTitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        productTitleLabel.textColor = .black
        
        // Configure Description Label
        productDescriptionLabel.numberOfLines = 2
        productDescriptionLabel.lineBreakMode = .byTruncatingTail
        productDescriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        productDescriptionLabel.textColor = .darkGray
        
        // Configure Image View
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
    }
    
    func populateCell(for model: Products) {
        productTitleLabel.text = model.title
        
        // Strip HTML tags & set description
        productDescriptionLabel.text = model.summaryHTML.stripHTMLTags()

        // Set placeholder image
        productImageView.image = UIImage(named: "dummy_product")

        // Load the correct image using the product ID
        viewModel.imageCacheService.loadImage(for: model.id, from: model.image.src) { [weak self] id, image in
            DispatchQueue.main.async {
                // Ensure the image belongs to the correct model by matching the id
                if id == model.id {
                    self?.productImageView.image = image
                }
            }
        }
    }

    
}
