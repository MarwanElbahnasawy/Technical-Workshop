//
//  CategoryCollectionViewCell.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryImageView.layer.cornerRadius = 20
        categoryImageView.layer.masksToBounds = true
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                categoryImageView.backgroundColor = UIColor(named: Constants.categoriesBackgroundColorSelected)
            } else {
                categoryImageView.backgroundColor = UIColor(named: Constants.categoryBackgroundColor)
            }
        }
    }
        
        func configure(categoryItem: CategoryItem, isFirst: Bool = false){
            categoryTitle.text = categoryItem.title
            categoryImageView.image = UIImage(named: categoryItem.image.rawValue)
        }
    }
