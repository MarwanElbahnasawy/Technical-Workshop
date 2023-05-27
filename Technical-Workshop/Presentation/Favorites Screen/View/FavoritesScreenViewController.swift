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
    var mealID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteMealsCollectionView.register(UINib(nibName: Constants.mealCellNibAndIdentifierName, bundle: .main), forCellWithReuseIdentifier: Constants.mealCellNibAndIdentifierName)
        viewModel = FavoritesScreenViewModel(favouriteMealManager: CoreDataManager())
        favouriteMeals = viewModel.getAllFavouriteMeals()
        self.favouriteMealsCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        if favouriteMeals?.count == 0 {
            favouriteMealsCollectionView.backgroundView = favouriteBackground
        }
    }
    
    func deleteMeal(with mealID: Int) {
        viewModel.removeFavouriteMeal(for: mealID)
        favouriteMealsCollectionView.reloadData()
    }
    
    func convertToMealItem(from model: FavouriteMealModel) -> MealItem? {
        guard let mealID = model.mealID,
              let mealName = model.mealName,
              let mealServings = model.mealServings,
              let chiefName = model.chiefName,
              let mealType = model.mealType,
              let mealImage = model.mealImage else {
            return nil
        }
        
        let mealItem = MealItem(mealRecipe: mealName, chefName: chiefName, mealType: mealType, servings: mealServings, imageString: mealImage)
        return mealItem
    }
    
}

extension FavoritesScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favouriteMeals?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mealCellNibAndIdentifierName, for: indexPath) as! MealCollectionViewCell
        cell.cellDelegate = self
        cell.likeButton.imageView?.image = UIImage(systemName: "heart.fill")
        
        let currentMeal = (favouriteMeals?[indexPath.row])!
        mealID = currentMeal.mealID
        cell.configure(mealItem: convertToMealItem(from: currentMeal)!)
        
        return cell
    }
}

extension FavoritesScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favouriteMeal = favouriteMeals?[indexPath.item]
        // TODO: navigate to details screen
    }
}

extension FavoritesScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        let cellHeight: CGFloat = collectionView.frame.width * 0.25
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension FavoritesScreenViewController: MealCellDelgate{
    func didPressedFavBtn() {
        let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this meal?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { (action) in
            self.deleteMeal(with: self.mealID ?? 0)
            self.favouriteMealsCollectionView.reloadData()
        }))
        present(alert, animated: true, completion: nil)
    }
}
