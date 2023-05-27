//
//  FavoritesScreenViewController.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import UIKit

class FavoritesScreenViewController: UIViewController {
    
    @IBOutlet weak var favouriteBackground: UIView!
    @IBOutlet weak var favouriteMealsCollectionView: UICollectionView!
    
    var favouriteMeals: [FavouriteMealModel]?
    var viewModel: FavoritesScreenViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoritesScreenViewModel(favouriteMealManager: CoreDataManager())
        favouriteMeals = viewModel.getAllFavouriteMeals()
    }
    
    func deleteMeal(with mealID: Int) {
        viewModel.removeFavouriteMeal(for: mealID)
        favouriteMealsCollectionView.reloadData()
    }
    
    func getAllFavouriteMeals() {
        favouriteMeals = viewModel.getAllFavouriteMeals()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        favouriteMealsCollectionView.reloadData()
        if favouriteMeals == nil {
            favouriteMealsCollectionView.backgroundView = favouriteBackground
        }
    }
    
}

extension FavoritesScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteMeals?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteMealCell", for: indexPath)
        
        return cell
    }
}

extension FavoritesScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favouriteMeal = favouriteMeals?[indexPath.item]
        let mealID = favouriteMeal?.mealID ?? 0
        
        deleteMeal(with: mealID)
    }
}

extension FavoritesScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        let cellHeight: CGFloat = collectionView.frame.width * 0.25
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
