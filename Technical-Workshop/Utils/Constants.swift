//
//  Constants.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import Foundation
import UIKit
struct Constants {
    static let mealCellNibAndIdentifierName = "MealCollectionViewCell"
    static let categoriesCollectionViewCell = "categoriesCollectionViewCell"
    static let categoriesBackgroundColorSelected = "categoriesBackgroundColorSelected"
    static let categoryBackgroundColor = "categoryBackgroundColor"
    
    static func showToast(view :UIView , text :String){
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = text
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
