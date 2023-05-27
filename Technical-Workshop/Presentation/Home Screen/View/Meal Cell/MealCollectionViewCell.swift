//
//  MealCollectionViewCell.swift
//  Technical-Workshop
//
//  Created by moamen ali gomaa on 26/05/2023.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    
    var cellDelegate: MealCellDelgate?
    
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var mealRecipeLabel: UILabel!
    @IBOutlet weak var recipePlaceHolder: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipePlaceHolder.makeGradient()
    }
    @IBAction func favoriteButton(_ sender: Any) {
        cellDelegate?.didPressedFavBtn()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recipePlaceHolder.layer.cornerRadius = 10
        recipePlaceHolder.layer.masksToBounds = true
    }
    
    func configure(mealItem: MealItem){
        mealRecipeLabel.text = mealItem.mealRecipe
        chefNameLabel.text = mealItem.chefName
        mealTypeLabel.text = mealItem.mealType
        servingsLabel.text = mealItem.servings
        recipePlaceHolder.image = UIImage(named: mealItem.image.rawValue)
    }
    
    
}
protocol MealCellDelgate{
    func didPressedFavBtn()
}
