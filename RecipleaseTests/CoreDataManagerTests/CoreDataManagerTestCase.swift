//
//  CoreDataManagerTestCase.swift
//  RecipleaseTests
//
//  Created by elodie gage on 15/02/2024.
//    
//

import XCTest
@testable import Reciplease
import CoreData

class CoreDataManagerTestCase: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests Life Cycle
    
//    Wipe entre chaque test; delete les entites (beforeEach?)

    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    


    override func setUpWithError() throws {
      try super.setUpWithError()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
      // Create a fetch request for any kind of NSFetchRequestResult
      let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedRecipe")
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      try coreDataStack.persistentContainer.viewContext.execute(deleteRequest)
    }


    // MARK: - Tests
    
    func testAddRecipeToFavoritesMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataManager.addRecipe(title: "Chicken Vesuvio", totalTime: "", ingredients: "", yield: "http://www.recipes.com/recipes/8793/", image: "", uri: "111", url: "")
        XCTAssertTrue(!coreDataManager.favoriteRecipe.isEmpty)
        XCTAssertTrue(coreDataManager.favoriteRecipe.count == 1)
        XCTAssertTrue(coreDataManager.favoriteRecipe[0].title! == "Chicken Vesuvio")
    }
    
    func testDeleteOneRecipeMethod_WhenEntityIsDeleted_ThenShouldBeCorrectlyDeleted() {
        coreDataManager.removeRecipe(recipeUri: "111")
        coreDataManager.addRecipe(title: "Chicken Vesuvio", totalTime: "", ingredients: "", yield: "http://www.recipes.com/recipes/8793/", image: "", uri: "123", url: "")
        coreDataManager.addRecipe(title: "Strong Cheese", totalTime: "", ingredients: "", yield: "http://www.recipes.com/recipes/8793/", image: "", uri: "456", url: "")
        coreDataManager.removeRecipe(recipeUri: "123")
        debugPrint(coreDataManager.favoriteRecipe.count)
        XCTAssertTrue(!coreDataManager.favoriteRecipe.isEmpty)
        XCTAssertTrue(coreDataManager.favoriteRecipe.count == 1)
        XCTAssertTrue(coreDataManager.favoriteRecipe[0].uri! == "456")
    }
    
    func testCheckingIfRecipeIsAlreadyFavorite_WhenFuncIsCalling_ThenShouldReturnTrue() {
        coreDataManager.addRecipe(title: "Chicken Vesuvio", totalTime: "", ingredients: "", yield: "http://www.recipes.com/recipes/8793/", image: "", uri: "123", url: "")
        XCTAssertTrue(coreDataManager.checkIfRecipeIsAlreadySaved(recipeUri: "123"))
    }
    
}
