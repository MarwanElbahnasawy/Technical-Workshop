import XCTest
@testable import Technical_Workshop

class FavouriteMealViewModelTests: XCTestCase {
    
    var favouriteMealManagerMock: FavouriteMealManagerMock!
    var favouriteMealViewModel: FavoritesScreenViewModel!
    
    override func setUp() {
        super.setUp()
        favouriteMealManagerMock = FavouriteMealManagerMock()
        favouriteMealViewModel = FavoritesScreenViewModel(favouriteMealManager: favouriteMealManagerMock as! CoreDataManagerType)
    }
    
    override func tearDown() {
        favouriteMealManagerMock = nil
        favouriteMealViewModel = nil
        super.tearDown()
    }
    
    func testInsertFavouriteMeal() {
        // Given
        let favouriteMeal = FavouriteMealModel(chiefName: "John Doe",
                                               mealID: 1,
                                               mealType: "Breakfast",
                                               mealName: "Pancakes",
                                               mealServings: "2")
        
        // When
        favouriteMealViewModel.insertFavouriteMeal(favouriteMeal: favouriteMeal)
        
        // Then
        XCTAssertTrue(favouriteMealManagerMock.insertFavouriteMealCalled)
    }
    
    func testRemoveFavouriteMeal() {
        // Given
        let mealID = 1
        
        // When
        favouriteMealViewModel.removeFavouriteMeal(for: mealID)
        
        // Then
        XCTAssertTrue(favouriteMealManagerMock.removeFavouriteMealCalled)
        XCTAssertEqual(favouriteMealManagerMock.removedMealID, mealID)
    }
    
    func testGetAllFavouriteMeals() {
        // Given
        let favouriteMeals = [FavouriteMealModel(chiefName: "John Doe",
                                                 mealID: 1,
                                                 mealType: "Breakfast",
                                                 mealName: "Pancakes",
                                                 mealServings: "2"),
                              FavouriteMealModel(chiefName: "Jane Smith",
                                                 mealID: 2,
                                                 mealType: "Lunch",
                                                 mealName: "Salad",
                                                 mealServings: "1")]
        
        favouriteMealManagerMock.allFavouriteMeals = favouriteMeals
        
        // When
        let result = favouriteMealViewModel.getAllFavouriteMeals()
        
        // Then
        XCTAssertTrue(favouriteMealManagerMock.getAllFavouriteMealsCalled)
    }
    
    func testMealExists() {
        // Given
        let mealID = 1
        favouriteMealManagerMock.mealExistsReturnValue = true
        
        // When
        let result = favouriteMealViewModel.mealExists(for: mealID)
        
        // Then
        XCTAssertTrue(favouriteMealManagerMock.mealExistsCalled)
        XCTAssertEqual(favouriteMealManagerMock.checkedMealID, mealID)
        XCTAssertTrue(result)
    }
}

// MARK: - FavouriteMealManagerMock

class FavouriteMealManagerMock: FavoritesScreenViewModelType {
    
    var insertFavouriteMealCalled = false
    var insertedFavouriteMeal: FavouriteMealModel?
    
    var removeFavouriteMealCalled = false
    var removedMealID: Int?
    
    var getAllFavouriteMealsCalled = false
    var allFavouriteMeals: [FavouriteMealModel] = []
    
    var mealExistsCalled = false
    var checkedMealID: Int?
    var mealExistsReturnValue = false
    
    func insertFavouriteMeal(favouriteMeal: FavouriteMealModel) {
        insertFavouriteMealCalled = true
        insertedFavouriteMeal = favouriteMeal
    }
    
    func removeFavouriteMeal(for mealID: Int) {
        removeFavouriteMealCalled = true
        removedMealID = mealID
    }
    
    func getAllFavouriteMeals() -> [FavouriteMealModel] {
        getAllFavouriteMealsCalled = true
        return allFavouriteMeals
    }
    
    func mealExists(for mealID: Int) -> Bool {
        mealExistsCalled = true
        checkedMealID = mealID
        return mealExistsReturnValue
    }
}
