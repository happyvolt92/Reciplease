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

        cell.recipeTitle.text = recipe.title ?? "Untitled Recipe"
        cell.recipeTime.text = recipe.totalTime ?? "N/A"
        cell.recipeYield.text = recipe.yield ?? "N/A"


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
        performSegue(withIdentifier: "ShowRecipeDetail", sender: recipe)
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RecipeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RecipeCell")
        loadSavedData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadSavedData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRecipeDetail",
           let destinationVC = segue.destination as? RecipeController,
           let selectedRecipe = sender as? SavedRecipe {
            destinationVC.savedRecipe = selectedRecipe
        }
    }
}
