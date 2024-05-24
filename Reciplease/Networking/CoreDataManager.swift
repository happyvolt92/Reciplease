//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by elodie gage on 15/02/2024.
//    
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Properties
    
    let coreDataStack: CoreDataStack
    let managedObjectContext: NSManagedObjectContext
    
    var favoriteRecipe: [SavedRecipe] {
        let request: NSFetchRequest = SavedRecipe.fetchRequest()
        do {
           return try managedObjectContext.fetch(request)
        } catch {
            return []
        }
    }
    
    // MARK: - Initialization
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Methods
    
    // method to add recipe in Favorites
    func addRecipe(title: String, totalTime: String, ingredients: String, yield: String, image: String, uri: String, url: String) {
        
        let entity = SavedRecipe(context: managedObjectContext)
        entity.title = title
        entity.totalTime = totalTime
        entity.image = image
        entity.ingredients = ingredients
        entity.yield = yield
        entity.uri = uri
        entity.url = url
        
        coreDataStack.saveContext()
    }
    
    // method to remove recipe in Favorites
    func removeRecipe(recipeUri: String) {
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", recipeUri)
        if let result = try? managedObjectContext.fetch(request) {
            for object in result {
                managedObjectContext.delete(object)
            }
        }
    }
    
    // method to check if recipe is already in Favorites
    func checkIfRecipeIsAlreadySaved(recipeUri: String) -> Bool {
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", recipeUri)
        guard let recipes = try? managedObjectContext.fetch(request) else { return false}
        if recipes.isEmpty { return false }
        return true
    }
}
