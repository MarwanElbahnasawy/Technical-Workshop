//
//  HomeScreenViewModel.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

class HomeScreenViewModel: HomeScreenViewModelType {
    private let categoryItems = [CategoryItem(title: "Popular", image: .firstCategory), CategoryItem(title: "Breakfast", image: .secondCategory), CategoryItem(title: "Lunch", image: .thirdCategory), CategoryItem(title: "Dinner", image: .fourthCategory), CategoryItem(title: "Dessert", image: .fifthCategory)]
    
    var categoryItemsCount: Int {
        categoryItems.count
    }
    
    func categoryItem(at index: Int) -> CategoryItem {
        categoryItems[index]
    }
}
