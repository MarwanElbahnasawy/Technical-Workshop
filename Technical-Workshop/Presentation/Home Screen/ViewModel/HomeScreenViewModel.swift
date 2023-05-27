//
//  HomeScreenViewModel.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation
import Alamofire

class HomeScreenViewModel: HomeScreenViewModelType {
    private let categoryItems = [CategoryItem(title: "Popular", image: .firstCategory),
                                 CategoryItem(title: "Breakfast", image: .secondCategory),
                                 CategoryItem(title: "Lunch", image: .thirdCategory),
                                 CategoryItem(title: "Dinner", image: .fourthCategory),
                                 CategoryItem(title: "Dessert", image: .fifthCategory)]
    
    var mealItems = [MealItem]()
    
    var didRecieveRecipes: (() -> ())?
    
    func callListApi( tags :String , from :String = "0" , size :String = "20") {
        mealItems.removeAll()
        let param : [String: String] = ["size": size,"from": from,"tags": tags]
        APIServices.instance.getData(route: .list, method: .get, params: param, encoding: URLEncoding.default) {  [weak self] (dataurl: Root?, error) in
            guard let root = dataurl else {
                fatalError("root nil")
             }
            for i in 0 ... (root.results!.count - 1) {
                let meal = root.results![i]
                self?.mealItems.append(MealItem(mealRecipe: meal.name ?? "Unknown",
                                                chefName: meal.credits?[0].name ?? "by Tresha Lindo",
                                                mealType: meal.sections?[0].name ?? "Random",
                                                servings: String(meal.numServings ?? 0),
                                                imageString: meal.thumbnailURL ?? "",
                                                mealId: meal.id!))
                if i == root.results!.count - 1 {
                    self?.didRecieveRecipes?()
                }
            }
        }
    }
    
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
