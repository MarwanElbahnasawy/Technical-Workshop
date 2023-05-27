protocol FavoritesScreenViewModelType {
    func insertFavouriteMeal(favouriteMeal: FavouriteMealModel)
    func removeFavouriteMeal(for mealID: Int)
    func getAllFavouriteMeals() -> [FavouriteMealModel]?
    func mealExists(for mealID: Int) -> Bool
}

class FavoritesScreenViewModel: FavoritesScreenViewModelType{
    private let coreDataManager: CoreDataManagerType
    
    init(favouriteMealManager: CoreDataManagerType) {
        self.coreDataManager = favouriteMealManager
    }
    
    func insertFavouriteMeal(favouriteMeal: FavouriteMealModel) {
        coreDataManager.insertFavouriteMeal(favouriteMeal: favouriteMeal)
    }
    
    func removeFavouriteMeal(for mealID: Int) {
        coreDataManager.removeFavouriteMeal(for: mealID)
    }
    
    func getAllFavouriteMeals() -> [FavouriteMealModel]? {
        return coreDataManager.getAllFavouriteMeals()
    }
    
    func mealExists(for mealID: Int) -> Bool {
        return coreDataManager.mealExists(for: mealID)
    }
}
