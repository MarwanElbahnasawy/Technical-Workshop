import CoreData

protocol CoreDataManagerType {
    func insertFavouriteMeal(favouriteMeal: FavouriteMealModel)
    func removeFavouriteMeal(for mealID: Int)
    func getAllFavouriteMeals() -> [FavouriteMealModel]?
    func mealExists(for mealID: Int) -> Bool
}

class CoreDataManager: CoreDataManagerType {
    var context: NSManagedObjectContext?
    
    init(context: NSManagedObjectContext? = nil) {
        self.context = context
    }
    
    // MARK: Insert a favourite meal into CoreData
    
    func insertFavouriteMeal(favouriteMeal: FavouriteMealModel) {
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteMeal", in: context!)
        let favouriteMealEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        favouriteMealEntity.setValue(favouriteMeal.mealID, forKey: "mealID")
        favouriteMealEntity.setValue(favouriteMeal.mealType, forKey: "mealType")
        favouriteMealEntity.setValue(favouriteMeal.mealServings, forKey: "mealServings")
        favouriteMealEntity.setValue(favouriteMeal.chiefName, forKey: "chiefName")
        favouriteMealEntity.setValue(favouriteMeal.mealName, forKey: "mealName")
        favouriteMealEntity.setValue(favouriteMeal.mealImage, forKey: "mealImage")
        
        do {
            try context!.save()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    // MARK: Delete a favourite meal from CoreData
    
    func removeFavouriteMeal(for mealID: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteMeal")
        let predicate = NSPredicate(format: "mealID == %@", mealID)
        
        fetchRequest.predicate = predicate
        
        do {
            let teamObject = try context?.fetch(fetchRequest)
            
            context?.delete(teamObject![0])
            try context?.save()
            
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    // MARK: Get all favourite meals
    
    func getAllFavouriteMeals() -> [FavouriteMealModel]? {
        var favouriteMeals : [FavouriteMealModel] = []
        var favouriteMeal : FavouriteMealModel!
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteMeal")
        
        do {
            let meals = try context?.fetch(fetchRequest)
            
            for meal in meals ?? [] {
                favouriteMeal = FavouriteMealModel(
                    chiefName: meal.value(forKey: "chiefName") as? String,
                    mealImage: meal.value(forKey: "mealImage") as? String,
                    mealID: meal.value(forKey: "mealID") as? Int,
                    mealType: meal.value(forKey: "mealType") as? String,
                    mealName: meal.value(forKey: "mealName") as? String,
                    mealServings: meal.value(forKey: "mealServings") as? String)
                    
                favouriteMeals.append(favouriteMeal)
            }
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        return favouriteMeals
    }
    
    // MARK: Meal exists?
    
    func mealExists(for mealID: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteMeal")
        let predicate = NSPredicate(format: "mealID == %d", mealID)
        
        fetchRequest.predicate = predicate
        
        do {
            let count = try context?.count(for: fetchRequest)
            return count == 1
        } catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
    }
}
