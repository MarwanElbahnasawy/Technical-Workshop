//
//  HomeScreenViewController.swift
//  Technical-Workshop
//
//  Created by Marwan Elbahnasawy on 26/05/2023.
//

import UIKit

class HomeScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var homeTableView: UITableView!
    
    
    private lazy var viewModel: HomeScreenViewModelType = {
        return HomeScreenViewModel()
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    // MARK: Collection View Callback Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let currentCategoryItem = viewModel.categoryItem(at: indexPath.row)
        cell.configure(categoryItem: currentCategoryItem)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = categoriesCollectionView.bounds.size.width * 0.2
        let height = categoriesCollectionView.bounds.size.height
        return CGSize(width: width, height: height)
    }

    // MARK: Table View Callback Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
