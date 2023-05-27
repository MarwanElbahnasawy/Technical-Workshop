//
//  MealItem.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

struct MealItem {
    let mealRecipe : String
    let chefName : String
    let mealType : String
    let servings : String
    let image : String
    
    init(mealRecipe: String, chefName : String, mealType : String, servings : String, image: String) {
        self.mealRecipe = mealRecipe
        self.chefName = chefName
        self.mealType = mealType
        self.servings = servings
        self.image = image
    }
}
