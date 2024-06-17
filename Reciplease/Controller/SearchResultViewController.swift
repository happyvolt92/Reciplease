import UIKit

class SearchResultViewController: UITableViewController {
    
    // MARK: - Properties
    
    let recipeService = RecipleaseService()
    var recipes = [Hit]()
    var dataRecipe: RecipleaseData?
    var ingredients = [String]()
    var from = 0
    var to = 20
    var isLoading = false
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCellTableView
        let recipe = recipes[indexPath.row].recipe
        
        cell.recipeTitle.text = recipe.label
        
        if let imageUrl = URL(string: recipe.image.absoluteString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.recipeImage.image = UIImage(data: imageData)
                        cell.recipeImage.addBlackGradientLayerInForeground()
                    }
                }
            }
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row].recipe
        performSegue(withIdentifier: "ResultToDetail", sender: recipe)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !isLoading else { return }
        isLoading = true
        from += 20
        to += 20
        recipeService.request(from: from, to: to, ingredients: ingredients, completionHandler: { (recipe, error) in
            self.isLoading = false
            DispatchQueue.main.async {
                if error == nil {
                    self.recipes.append(contentsOf: recipe?.hits ?? [])
                    self.tableView.reloadData()
                } else {
                    self.alert(title: "Erreur", message: "Veuillez vérifier les informations renseignées et votre connexion !")
                }
            }
        })
    }
    
    // MARK: - View life cycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataController = segue.destination as? RecipeController {
            dataController.recipe = sender as? Recipe
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
         let nib = UINib(nibName: "RecipeCell", bundle: nil)
         tableView.register(nib, forCellReuseIdentifier: "RecipeCell")
        
    }
}
