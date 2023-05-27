import XCTest
import CoreData

@testable import Technical_Workshop

class FavouriteMealManagerTests: XCTestCase {
    
    var context: NSManagedObjectContext!
    var sut: CoreDataManagerType!  //system under test
    
    override func setUp() {
        super.setUp()
        
        let container = NSPersistentContainer(name: "Sportify")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        context = container.viewContext
        
        sut = CoreDataManager(context: context)
    }
    
    override func tearDown() {
        super.tearDown()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMeal")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        context = nil
        sut = nil
    }

    // MARK: Insert a favourite meal into CoreData
    
    func testSut_InsertFavouriteMeal_coiunt() {

        // Given
        let favouriteMeal = FavouriteMealModel(
            chiefName: "Ahmad",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "2")
        
        // When
        sut.insertFavouriteMeal(favouriteMeal: favouriteMeal)
        
        // Then
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMeal")
        let result = try! context.fetch(fetchRequest) as! [NSManagedObject]
        
        XCTAssertEqual(result.count, 1)
    }
    
    // MARK: Delete a favourite meal from CoreData
    
    func testRemoveFavouriteMeal() {
        // Given
        let favouriteMeal = FavouriteMealModel(
            chiefName: "Ahmad",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "3")
        sut.insertFavouriteMeal(favouriteMeal: favouriteMeal)
        
        // When
        sut.removeFavouriteMeal(for: 1)
        
        // Then
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteMeal")
        let result = try! context.fetch(fetchRequest) as! [NSManagedObject]
        
        XCTAssertEqual(result.count, 0)
    }
    
    //MARK: Get all favourite meals
    
    func testGetAllFavouriteMeals() {
        // Given
        let favouriteMeal1 = FavouriteMealModel(
            chiefName: "Ahmad",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "3")
        sut.insertFavouriteMeal(favouriteMeal: favouriteMeal1)
        
        let favouriteMeal2 = FavouriteMealModel(
            chiefName: "Hemeda",
            mealID: 2,
            mealType: "Lunch",
            mealName: "Spaghetti",
            mealServings: "2")
        sut.insertFavouriteMeal(favouriteMeal: favouriteMeal2)
        
        // When
        let result = sut.getAllFavouriteMeals()
        
        // Then
        XCTAssertEqual(result.count, 2)
    }
    
    // MARK: Meal exists?
    
    func testMealExists() {
        // Given
        let favouriteMeal = FavouriteMealModel(
            chiefName: "Ahmad",
            mealID: 1,
            mealType: "Dinner",
            mealName: "Koshary",
            mealServings: "3")
        sut.insertFavouriteMeal(favouriteMeal: favouriteMeal)
        
        // When
        let result1 = sut.mealExists(for: 1)
        let result2 = sut.mealExists(for: 2)
        
        // Then
        XCTAssertTrue(result1)
        XCTAssertFalse(result2)
    }
}
