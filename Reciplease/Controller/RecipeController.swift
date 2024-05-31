//
//  RecipeController.swift
//  Reciplease
//
//  Created by elodie gage on 15/02/2024.
//
//

import UIKit
import CoreData

class RecipeController: UIViewController {
    
    // MARK: - Properties
    
    var recipe: Recipe?
    var favoriteRecipe: [SavedRecipe] {
        let request: NSFetchRequest = SavedRecipe.fetchRequest()
        do {
           return try AppDelegate.viewContext.fetch(request)
        } catch {
            return []
        }
    }

    // MARK: - Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet var favoritebutton: UIBarButtonItem!
    
    // MARK: - Methods
    
    func addRecipe(title: String, totalTime: String, ingredients: String, yield: String, image: String, uri: String, url: String) {
        
        let entity = SavedRecipe(context: AppDelegate.viewContext)
        entity.title = title
        entity.totalTime = totalTime
        entity.image = image
        entity.ingredients = ingredients
        entity.yield = yield
        entity.uri = uri
        entity.url = url
        
        do {
            try AppDelegate.viewContext.save()
            print("On a \(favoriteRecipe.count) recette(s)")
            let image = UIImage(systemName: "star.fill")
            self.favoritebutton.image = image
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func removeRecipe() {
        guard let recipe = recipe else { return }
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", recipe.uri)
        if let result = try? AppDelegate.viewContext.fetch(request) {
            for object in result {
                AppDelegate.viewContext.delete(object)
                print("On a \(favoriteRecipe.count) recette(s)")
                let image = UIImage(systemName: "star")
                self.favoritebutton.image = image
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func viewRecipe(_ sender: UIButton) {
        guard let stringUrl = recipe?.url.absoluteString else { return }
        guard let url = URL(string: stringUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func saveRecipe(_ sender: UIBarButtonItem) {
        guard let recipe = recipe else { return }
        if favoritebutton.image == UIImage(systemName: "star") {
            guard let title = recipeTitle.text,
                  let totalTime = recipeTime.text,
                  let yield = recipeYield.text else { return }
            let ingredients = recipe.ingredientLines.joined(separator: "\n- ")
            addRecipe(title: title, totalTime: totalTime, ingredients: "- " + ingredients, yield: yield, image: "\(recipe.image)", uri: "\(recipe.uri)", url: "\(recipe.url)")
        } else {
            removeRecipe()
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let recipe = recipe else { return }
        recipeIngredients.text = "- " + recipe.ingredientLines.joined(separator: "\n- ")
        
        guard let imageUrl = URL(string: "\(recipe.image)"),
              let imageData = try? Data(contentsOf: imageUrl) else { return }
        recipeImage.image = UIImage(data: imageData)
        recipeImage.addBlackGradientLayerInForeground()
        
        recipeYield.text = "\(recipe.yield)"
        recipeTime.text = "\(recipe.totalTime)"
        recipeTitle.text = "\(recipe.label)"
        
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", recipe.uri)
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return }
        if recipes.count > 0 {
            self.favoritebutton.image = UIImage(systemName: "star.fill")
        } else {
            self.favoritebutton.image = UIImage(systemName: "star")
        }
    }
}
