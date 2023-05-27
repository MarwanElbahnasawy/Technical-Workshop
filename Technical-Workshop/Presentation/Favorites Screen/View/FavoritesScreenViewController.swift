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
    private lazy var db: CoreDataManagerType = {
        CoreDataManager()
    }()
    
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
        } else {
            favouriteMealsCollectionView.backgroundView = .none
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favouriteMeals = viewModel.getAllFavouriteMeals()
        self.favouriteMealsCollectionView.reloadData()
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
        
        let mealItem = MealItem(mealRecipe: mealName, chefName: chiefName, mealType: mealType, servings: mealServings, imageString: mealImage, mealId: mealID)
        return mealItem
    }
    
}

extension FavoritesScreenViewController: UICollectionViewDataSource, MealCellDelgate {
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
        cell.currentMealItem = MealItem(mealRecipe: currentMeal.mealName ?? "", chefName: currentMeal.chiefName ?? "", mealType: currentMeal.mealType ?? "", servings: currentMeal.mealServings ?? "", imageString: currentMeal.mealImage ?? "", mealId: currentMeal.mealID ?? 1)
        return cell
    }
    
    func didPressedFavBtn(mealItem: MealItem) {
        if !db.mealExists(for: mealItem.mealId){
            db.insertFavouriteMeal(favouriteMeal: FavouriteMealModel(chiefName: mealItem.chefName, mealImage: mealItem.imageString, mealID: mealItem.mealId, mealType: mealItem.mealType, mealName: mealItem.mealRecipe, mealServings: mealItem.servings))
        } else {
            let alertController = UIAlertController(title: "Meal already exists", message: "The meal you selected already exists in your favorites", preferredStyle: .alert)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.db.removeFavouriteMeal(for: mealItem.mealId)
                DispatchQueue.main.async {
                    self.favouriteMeals = self.viewModel.getAllFavouriteMeals()
                    self.favouriteMealsCollectionView.reloadData()
                    if self.db.getAllFavouriteMeals()?.count == 0 {
                        self.favouriteMealsCollectionView.backgroundView = self.favouriteBackground
                    }
                }
            })
            let cancelAction = UIAlertAction(title: "Canel", style: .cancel)
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true)
        }
        
    }
    
    
}

extension FavoritesScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favouriteMeal = favouriteMeals?[indexPath.item]
        let detailsViewController = UIStoryboard(name: "DetailsScreenStoryboard", bundle: nil) .instantiateViewController(withIdentifier: "DetailsScreenViewController") as! DetailsScreenViewController
        let detailsViewModel = DetailsScreenViewModel(id: String(favouriteMeal!.mealID!))
        detailsViewController.viewModel = detailsViewModel
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension FavoritesScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = favouriteMealsCollectionView.bounds.size.width
        let height = favouriteMealsCollectionView.bounds.size.height * 0.3
        return CGSize(width: width, height: height)
    }
}

