//
//  HomeScreenViewController.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import UIKit
import Alamofire
import Lottie

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var mealsCollectionView: UICollectionView!
    @IBOutlet weak var lottieView: AnimationView!
    
    private lazy var viewModel: HomeScreenViewModelType = {
        HomeScreenViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableLottie()
        mealsCollectionView.register(UINib(nibName: Constants.mealCellNibAndIdentifierName, bundle: .main), forCellWithReuseIdentifier: Constants.mealCellNibAndIdentifierName)
        self.tabBarController?.tabBar.tintColor = UIColor(named: "LikeButtonColor")
        viewModel.callListApi(tags: "middle_eastern", from: "0", size: "10")
        viewModel.didRecieveRecipes = { [weak self] in
            self?.mealsCollectionView.reloadData()
            self?.disableLottie()
        }
    }
    
}

extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View: Number of items in section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesCollectionView {
            return viewModel.categoryItemsCount
        } else{
            return viewModel.mealsItemsCount
        }
    }
    
    // MARK: Collection View: Configuring cells
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.categoriesCollectionView {
            let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.categoriesCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell
            let currentCategoryItem = viewModel.categoryItem(at: indexPath.row)
            if indexPath.row == 0 {
                cell.configure(categoryItem: currentCategoryItem, isFirst: true)
                categoriesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            } else {
                cell.configure(categoryItem: currentCategoryItem)
            }
            
            return cell
        } else{
            let cell = mealsCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.mealCellNibAndIdentifierName, for: indexPath) as! MealCollectionViewCell
            let currentMealItem = viewModel.mealItem(at: indexPath.row)
            cell.configure(mealItem: currentMealItem)
            return cell
        }
    }
    
    // MARK: Collection View: setting sizes of items
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.categoriesCollectionView {
            let width = categoriesCollectionView.bounds.size.width * 0.2
            let height = categoriesCollectionView.bounds.size.height
            return CGSize(width: width, height: height)
        } else{
            let width = mealsCollectionView.bounds.size.width
            let height = mealsCollectionView.bounds.size.height * 0.4
            return CGSize(width: width, height: height)
        }
    }
    
    // MARK: Collection View: Selecting an item
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoriesCollectionView {
            enableLottie()
            switch indexPath.row {
            case 0:
                viewModel.callListApi(tags: "middle_eastern", from: "0", size: "10")
            case 1:
                viewModel.callListApi(tags: "breakfast", from: "0", size: "10")
            case 2:
                viewModel.callListApi(tags: "lunch", from: "0", size: "10")
            case 3:
                viewModel.callListApi(tags: "dinner", from: "0", size: "10")
            default:
                viewModel.callListApi(tags: "desserts", from: "0", size: "10")
            }
        }
        if collectionView == self.mealsCollectionView {
            let mealSelected = viewModel.mealItem(at: indexPath.row)
            let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsScreenViewController") as! DetailsScreenViewController
            // send id
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func reloadMealsCollectionView() {
        mealsCollectionView.reloadData()
    }
    
    func enableLottie(){
        DispatchQueue.main.async {
            self.lottieView.isHidden = false
            self.mealsCollectionView.isHidden = true
            self.lottieView.setUpMyView(name: "loading")
        }
    }
    
    func disableLottie(){
        DispatchQueue.main.async {
            self.mealsCollectionView.isHidden = false
            self.lottieView.isHidden = true
        }
    }
    
}



