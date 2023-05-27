//
//  DetailsScreenViewModelType.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

protocol DetailsScreenViewModelType {
    func callItemApi( recipe_id :String )
    func callListSimilaritiesApi( recipe_id :String )
    var bindResultsToViewController : (()->()) { get set }
    var bindItemToViewController : (()->()) { get set }
    var VMResultItem : Result! { get set }
    var VMResults : [Result]! { get set }
}
