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
    
    func configure(categoryItem: CategoryItem){
        categoryTitle.text = categoryItem.title
        categoryImageView.image = UIImage(named: categoryItem.image.rawValue)
    }
}
