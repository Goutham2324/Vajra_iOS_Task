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
        
        // Strip HTML tags & limit to two lines
       productDescriptionLabel.text = model.summaryHTML.stripHTMLTags()
               
        // Load Image
        productImageView.image = UIImage(named: "dummy_product") // Placeholder image
        viewModel.imageCacheService.loadImage(from: model.image.src) { image in
            DispatchQueue.main.async {
                self.productImageView.image = image
            }
        }
    }
    
}
