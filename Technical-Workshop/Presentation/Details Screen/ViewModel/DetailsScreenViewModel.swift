//
//  DetailsScreenViewModel.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation
import Alamofire

class DetailsScreenViewModel: DetailsScreenViewModelType {
    var id: String
    var bindResultsToViewController : (()->()) = {}
    var bindItemToViewController : (()->()) = {}
    var VMResultItem : Result?{
        didSet {
            bindItemToViewController() // call
        }
    }
    var VMResults : [Result] = [] {
        didSet {
            bindResultsToViewController() // call
        }
    }
    
    init(id: String){
        self.id = id
    }
   
    func getItem(atIndexPath: IndexPath)->Result?{
        return VMResults[atIndexPath.row]
    }
    
    func getItemsCount()->Int?{
        return VMResults.count
    }
    
    func callListSimilaritiesApi() {
        let param : [String: String] = ["recipe_id": id]
        APIServices.instance.getData(route: .list, method: .get, params: param, encoding: URLEncoding.default) {  [weak self] (data: Root?, error) in
            self?.VMResults = data?.results ?? []
        }
    }

    func callItemApi() {
        let param : [String: String] = ["id": id]
        APIServices.instance.getData(route: .getMoreInfo, method: .get, params: param, encoding: URLEncoding.default) {  [weak self] (data: Result?, error) in
            self?.VMResultItem = data
        }
    }
}
