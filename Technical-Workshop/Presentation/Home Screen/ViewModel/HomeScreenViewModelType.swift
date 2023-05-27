//
//  HomeScreenViewModelType.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

protocol HomeScreenViewModelType {
    var categoryItemsCount: Int { get }
    var mealsItemsCount: Int { get }
    var mealItems : [MealItem] { get set }
    var didRecieveRecipes: (() -> ())? { get set }
    func categoryItem(at index: Int) -> CategoryItem
    func mealItem(at index: Int) -> MealItem
    func callListApi( tags :String , from :String , size :String)
}
