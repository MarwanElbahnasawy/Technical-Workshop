//
//  ViewController.swift
//  Created by mo_fathy on 26/05/2023.
//

import AVKit
import AVFoundation
import Alamofire
import Lottie
import UIKit

class DetailsScreenViewController: UIViewController {

    //MARK: - @IBOutlet

    @IBOutlet weak var labServing: UILabel!
    @IBOutlet weak var labMealType: UILabel!
    @IBOutlet weak var labMealName: UILabel!
    @IBOutlet weak var imageMeal: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadingView: AnimationView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var IngredientsTableViewheight: NSLayoutConstraint!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var IngredientstableView: UITableView!
    @IBOutlet weak var instructionsTableView: UITableView!
    
    //MARK: - Properties
    
    var viewModel: DetailsScreenViewModelType?
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailsScreenViewModel(id: viewModel?.id ?? "863" )
        loadingStart()
        registerCell()
        observeData()
        viewModel?.callListSimilaritiesApi()
        viewModel?.callItemApi()
    }
    
    //MARK: - Functions

    @IBAction func videoButton(_ sender: UIButton) {
        if let url = viewModel?.VMResultItem?.videoURL{
        try? playVideo(url: url.asURL())
     }else{
         Constants.showToast(view: view.self, text: "No video To Show")
     }
    }
    
    @IBAction func favButton(_ sender: UIButton) {
        
    }
    
    func setUpView(item: Result?){
        imageMeal.gradientBackground(from: UIColor.clear, to: UIColor.black, direction: .topToBottom)
        imageMeal.downloadImage(url: item?.thumbnailURL, placeHolder: UIImage(named: "Recipe placeholder"))
        labMealName.text = item?.name
        labServing.text = "Servings:\(item?.numServings ?? 0)"
        labMealType.text = item?.credits?[0].name ?? "McCormick"
    }
    
    func registerCell(){
        IngredientstableView.register(UINib(nibName: String(describing: TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TableViewCell.self))
        instructionsTableView.register(UINib(nibName: String(describing: TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TableViewCell.self))
        collectionView.register(UINib(nibName: String(describing: MealCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: MealCollectionViewCell.self))
    }
    
    func observeData(){
        //TO BE TESTED against memory leaks
        viewModel?.bindResultsToViewController = {() in
            self.dataSimilarItemsArived(data: self.viewModel?.VMResults)
        }
        viewModel?.bindItemToViewController = {() in
            self.dataArived(data: self.viewModel?.VMResultItem)
        }
    }
    
    func loadingStart(){
        scrollView.isHidden = true
        loadingView.isHidden = false
        loadingView.setUpMyView(name: "loading")
    }
    
    func loadingEnd(data : Bool){
        if data{
            scrollView.isHidden = false
            loadingView.isHidden = true
        }else{
            loadingView.setUpMyView(name: "error")
        }
    }
    
    func dataArived (data : Result?){
        DispatchQueue.main.async {
            if (data != nil) {
                self.IngredientstableView.reloadData()
                self.instructionsTableView.reloadData()
                self.viewWillLayoutSubviews()
                self.setUpView(item: data)
                self.loadingEnd(data: true)
            }else{
                self.loadingEnd(data: false)
            }
        }
    }
    
    func dataSimilarItemsArived (data: [Result]?){
        DispatchQueue.main.async {
            if (data != nil) {
                self.collectionView.reloadData()
                self.viewWillLayoutSubviews()
            }
        }
    }
    
    func playVideo(url: URL) {
         let player = AVPlayer(url: url)
         let vc = AVPlayerViewController()
         vc.player = player
         self.present(vc, animated: true) { vc.player?.play() }
     }
}

extension DetailsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillLayoutSubviews() {
        self.tableViewheight.constant = self.instructionsTableView.contentSize.height
        self.IngredientsTableViewheight.constant = self.IngredientstableView.contentSize.height
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case IngredientstableView:
            return viewModel?.VMResultItem?.sections?.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch tableView {
        case IngredientstableView:
            return viewModel?.VMResultItem?.sections?[section].name
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case IngredientstableView:
            return viewModel?.VMResultItem?.sections![section].components?.count ?? 0
        default:
            return viewModel?.VMResultItem?.instructions?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case IngredientstableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.label.text = viewModel?.VMResultItem?.sections?[indexPath.section].components?[indexPath.row].rawText
            viewWillLayoutSubviews()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
            cell.label.text = viewModel?.VMResultItem?.instructions?[indexPath.row].displayText
            viewWillLayoutSubviews()
            return cell
        }
    }
   
}



extension DetailsScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View: Number of items in section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.VMResults.count ?? 0
    }
   
    // MARK: Collection View: Configuring cells
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MealCollectionViewCell", for: indexPath) as! MealCollectionViewCell
         let currentMealItem = viewModel?.VMResults[indexPath.row]
        let meal = MealItem(mealRecipe: currentMealItem?.name ?? "mealRecipe", chefName: currentMealItem?.sections?[0].name ?? "chefName", mealType: currentMealItem?.sections?[0].name ?? "sections", servings: "\(currentMealItem?.numServings ?? 0)", imageString: currentMealItem?.thumbnailURL ?? "", mealId: currentMealItem?.id ?? 1)
         cell.configure(mealItem: meal)
        return cell
    }
 
    // MARK: Collection View: setting sizes of items
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width * 0.8
        let height = collectionView.bounds.size.height
        return CGSize(width: width, height: height)
    }
}





