// FavoritesController.swift

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCellTableView
        let recipe = favoriteRecipe[indexPath.row]

        if let title = recipe.title {
            cell.recipeTitle.text = title
        } else {
            cell.recipeTitle.text = "Untitled Recipe"
            print("Unable to retrieve recipe title for recipe at index \(indexPath.row)")
        }
        
        cell.recipeTime.text = recipe.totalTime
//        cell.recipeIngredients.text = recipe.ingredients
        cell.recipeYield.text = recipe.yield

        if let imageUrlString = recipe.image, let url = URL(string: imageUrlString) {
          ImageDownloader.loadImage(from: url) { image in
            cell.recipeImage.image = image
            cell.recipeImage.addBlackGradientLayerInForeground()
          }
        } else {
          cell.recipeImage.image = nil
        }

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

//        code a refacto avec favori
            let nib = UINib(nibName: "RecipeCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "RecipeCell")
           
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
