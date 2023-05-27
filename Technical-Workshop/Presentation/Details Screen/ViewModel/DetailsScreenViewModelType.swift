//
//  DetailsScreenViewModelType.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

protocol DetailsScreenViewModelType {
    var id: String { get set }
    var bindResultsToViewController: (()->()) { get set }
    var bindItemToViewController: (()->()) { get set }
    var VMResultItem: Result? { get set }
    var VMResults: [Result] { get set }
    func callItemApi()
    func callListSimilaritiesApi()
    func getItemsCount()->Int?
    func getItem(atIndexPath: IndexPath)->Result?
}
