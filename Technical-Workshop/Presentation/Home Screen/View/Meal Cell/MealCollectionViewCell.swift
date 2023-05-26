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
        recipePlaceHolder.makeGradient()
    }
    @IBAction func favoriteButton(_ sender: Any) {
        cellDelegate?.didPressedFavBtn()
    }
    func setup(){
        //TODO pass object to setup cell
    }
}
protocol MealCellDelgate{
    func didPressedFavBtn()
}
