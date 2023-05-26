//
//  CategoryItem.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation

struct CategoryItem {
    let title : String
    let image : CategoryImage
    
    init(title: String, image: CategoryImage) {
        self.title = title
        self.image = image
    }
}
