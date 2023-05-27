//
//  MealItem.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

struct MealItem {
    let mealId : Int
    let mealRecipe : String
    let chefName : String
    let mealType : String
    let servings : String
    let imageString : String
    
    init (mealRecipe: String, chefName : String, mealType : String, servings : String, imageString: String, mealId : Int) {
        self.mealRecipe = mealRecipe
        self.chefName = chefName
        self.mealType = mealType
        self.servings = servings
        self.imageString = imageString
        self.mealId = mealId
    }
}
