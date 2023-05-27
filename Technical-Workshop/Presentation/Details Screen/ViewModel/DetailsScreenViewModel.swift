//
//  DetailsScreenViewModel.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation
import Alamofire

class DetailsScreenViewModel: DetailsScreenViewModelType {
    
    var bindResultsToViewController : (()->()) = {}
    var bindItemToViewController : (()->()) = {}
    var VMResultItem : Result!{
        didSet {
            bindItemToViewController() // call
        }
    }
    var VMResults : [Result]!{
        didSet {
            bindResultsToViewController() // call
        }
    }
    
    func callListSimilaritiesApi( recipe_id :String ) {
        let param : [String: String] = ["recipe_id": recipe_id]
        APIServices.instance.getData(route: .list, method: .get, params: param, encoding: URLEncoding.default) {  [weak self] (data: Root?, error) in
            self?.VMResults = data?.results
        }
    }

    func callItemApi( recipe_id :String ) {
        let param : [String: String] = ["recipe_id": recipe_id]
        APIServices.instance.getData(route: .list, method: .get, params: param, encoding: URLEncoding.default) {  [weak self] (data: Root?, error) in
            self?.VMResultItem = data?.results?.first
        }
    }

}
