//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by elodie gage on 15/02/2024..
//    
//

import UIKit
import CoreData

class FavoriteRecipeController: UIViewController {
    
    // MARK: - Properties
    
    var recipe: SavedRecipe?
    
    // MARK: - Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var favoritebutton: UIBarButtonItem!
    
    // MARK: - Methods
    
    func removeRecipe() {
        let request: NSFetchRequest<SavedRecipe> = SavedRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "uri == %@", recipe!.uri!)
        if let result = try? AppDelegate.viewContext.fetch(request) {
            for object in result {
                AppDelegate.viewContext.delete(object)
                let image = UIImage(systemName: "star")
                self.favoritebutton.image = image
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func viewRecipe(_ sender: UIButton) {
        guard let stringUrl = recipe?.url else { return }
        guard let url = URL(string: stringUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func tappedFavoriteButton(_ sender: UIBarButtonItem) {
        if favoritebutton.image == UIImage(systemName: "star.fill") {
            removeRecipe()
        } else {
            
        }
    }
    
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ASYNCHRONOUS
        if let urlString = recipe?.image,
           let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.recipeImage.image = UIImage(data: data)
                        self.recipeImage.addBlackGradientLayerInForeground()
                    }
                }
            }
        } else {
            recipeImage.image = nil
        }
        
        recipeYield.text = recipe?.yield ?? "N/A"
        recipeTime.text = recipe?.totalTime ?? "N/A"
        recipeTitle.text = recipe?.title ?? "Untitled Recipe"
        recipeIngredients.text = recipe?.ingredients ?? "No ingredients available"
        
        self.favoritebutton.image = UIImage(systemName: "star.fill")
    }
}
