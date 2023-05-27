import XCTest
@testable import Technical_Workshop

class FavoritesScreenViewModelTests: XCTestCase {
    
    var viewModel: FavoritesScreenViewModelType!
    var coreDataManager: CoreDataManagerType!
    
    override func setUp() {
        super.setUp()
        coreDataManager = MockCoreDataManager()
        viewModel = FavoritesScreenViewModel(favouriteMealManager: coreDataManager)
    }
    
    override func tearDown() {
        coreDataManager = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testInsertFavouriteMeal() {
        let favouriteMeal = FavouriteMealModel(
            chiefName: "Ahmad",
            mealImage: "",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "2")
        viewModel.insertFavouriteMeal(favouriteMeal: favouriteMeal)
        let favouriteMeals = coreDataManager.getAllFavouriteMeals()
        XCTAssertEqual(favouriteMeals?.count, 1)
    }
    
    func testRemoveFavouriteMeal() {
        let favouriteMeal = FavouriteMealModel(
            chiefName: "Ahmad",
            mealImage: "",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "2")
        viewModel.insertFavouriteMeal(favouriteMeal: favouriteMeal)
        
        viewModel.removeFavouriteMeal(for: 1)
        let favouriteMeals = coreDataManager.getAllFavouriteMeals()
        XCTAssertEqual(favouriteMeals?.count, 0)
    }
    
    func testGetAllFavouriteMeals() {
        let favouriteMeal1 = FavouriteMealModel(
            chiefName: "Ahmad",
            mealImage: "Data()",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "2")
        viewModel.insertFavouriteMeal(favouriteMeal: favouriteMeal1)
        
        let favouriteMeal2 = FavouriteMealModel(
            chiefName: "Mahmoud",
            mealImage: "",
            mealID: 2,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "3")
        viewModel.insertFavouriteMeal(favouriteMeal: favouriteMeal2)
        
        let favouriteMeals = viewModel.getAllFavouriteMeals()
        XCTAssertEqual(favouriteMeals?.count, 2)
    }
    
    func testMealExists() {
        let favouriteMeal = FavouriteMealModel(
            chiefName: "Ahmad",
            mealImage: "",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "2")
        viewModel.insertFavouriteMeal(favouriteMeal: favouriteMeal)
        
        XCTAssertTrue(viewModel.mealExists(for: 1))
        XCTAssertFalse(viewModel.mealExists(for: 2))
    }
}

class MockCoreDataManager: CoreDataManagerType {
    
    var favouriteMeals: [FavouriteMealModel]?
    
    func insertFavouriteMeal(favouriteMeal: FavouriteMealModel) {
        if favouriteMeals == nil {
            favouriteMeals = []
        }
        favouriteMeals?.append(favouriteMeal)
    }
    
    func removeFavouriteMeal(for mealID: Int) {
        favouriteMeals = favouriteMeals?.filter { $0.mealID != mealID }
    }
    
    func getAllFavouriteMeals() -> [FavouriteMealModel]? {
        return favouriteMeals
    }
    
    func mealExists(for mealID: Int) -> Bool {
        return favouriteMeals?.contains(where: { $0.mealID == mealID }) ?? false
    }
}
