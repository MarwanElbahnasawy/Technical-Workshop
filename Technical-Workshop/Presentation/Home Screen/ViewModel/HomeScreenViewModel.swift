//
//  HomeScreenViewModel.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

class HomeScreenViewModel: HomeScreenViewModelType {
    private let categoryItems = [CategoryItem(title: "Popular", image: .firstCategory),
                                 CategoryItem(title: "Breakfast", image: .secondCategory),
                                 CategoryItem(title: "Lunch", image: .thirdCategory),
                                 CategoryItem(title: "Dinner", image: .fourthCategory),
                                 CategoryItem(title: "Dessert", image: .fifthCategory)]
    
    private let mealItems = [MealItem(mealRecipe: "meal1", chefName: "name1", mealType: "mealtype1", servings: "servings1", image: .recipePlaceholder),
                             MealItem(mealRecipe: "meal2", chefName: "name2", mealType: "mealtype2", servings: "servings2", image: .recipePlaceholder),
                             MealItem(mealRecipe: "meal3", chefName: "name3", mealType: "mealtype3", servings: "servings3", image: .recipePlaceholder),
                             MealItem(mealRecipe: "meal4", chefName: "name4", mealType: "mealtype4", servings: "servings4", image: .recipePlaceholder),
                             MealItem(mealRecipe: "meal5", chefName: "name5", mealType: "mealtype5", servings: "servings5", image: .recipePlaceholder)]
    
    var categoryItemsCount: Int {
        categoryItems.count
    }
    
    func categoryItem(at index: Int) -> CategoryItem {
        categoryItems[index]
    }
    
    var mealsItemsCount: Int {
        mealItems.count
    }
    
    func mealItem(at index: Int) -> MealItem {
        mealItems[index]
    }
}
