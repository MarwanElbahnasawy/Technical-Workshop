//
//  MealCollectionViewCell.swift
//  Technical-Workshop
//
//  Created by moamen ali gomaa on 26/05/2023.
//

import UIKit

class MealCollectionViewCell: UICollectionViewCell {
    
    var cellDelegate: MealCellDelgate?
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var mealRecipeLabel: UILabel!
    @IBOutlet weak var recipePlaceHolder: UIImageView!
    
    var currentMealItem: MealItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipePlaceHolder.makeGradient()
    }
    @IBAction func favoriteButton(_ sender: Any) {
        cellDelegate?.didPressedFavBtn(mealItem: self.currentMealItem!)
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
        recipePlaceHolder.downloadImage(url: mealItem.imageString, placeHolder: UIImage(named: "Recipe placeholder"))
    }
    
    
}
protocol MealCellDelgate{
    func didPressedFavBtn(mealItem: MealItem)
}
