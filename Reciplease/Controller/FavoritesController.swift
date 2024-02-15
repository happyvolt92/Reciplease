//
//  FavoritesController.swift
//  Reciplease
//
//    Created by elodie gage on 15/02/2024.
//    
//

import UIKit
import CoreData

class FavoritesController: UITableViewController {
    
    // MARK: - Properties

    var favoriteRecipe = [SavedRecipe]()
    
    // MARK: - Methods
    
    func loadSavedData() {
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        
        do {
            favoriteRecipe = try AppDelegate.viewContext.fetch(request)
            tableView.reloadData()
        } catch {
            favoriteRecipe = []
        }
    }

    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipe.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        let recipe = favoriteRecipe[indexPath.row]
        
        cell.recipeTitle.text = recipe.title
        cell.recipeTime.text = recipe.totalTime
        let url = URL(string: recipe.image!)
        let imageData = NSData(contentsOf: url!)
        cell.recipeImage.image = UIImage(data: imageData! as Data)
        cell.recipeImage.addBlackGradientLayerInForeground()
        cell.recipeIngredients.text = recipe.ingredients
        cell.recipeYield.text = recipe.yield
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = favoriteRecipe[indexPath.row]
        performSegue(withIdentifier: "FavoritesToRecipe", sender: recipe)
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedData()
    }

    override func viewDidAppear(_ animated: Bool) {
        loadSavedData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataController = segue.destination as? FavoriteRecipeController {
            dataController.recipe = sender as? SavedRecipe
        }
    }
}
