//
//  SearchController.swift
//  Reciplease
//
//  Created by elodie gage on 15/02/2024.
//    
//

import UIKit

class SearchController: UIViewController, UITextViewDelegate {

    // MARK: - Properties
    
    let recipeService = RecipleaseService()
    var recipes = [Hit]()
    var dataRecipe: RecipleaseData?
    var ingredients = [String]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var ingredient: UITextField!
    @IBOutlet weak var listOfIngredients: UITextView!
    @IBOutlet weak var searchActivity: UIActivityIndicatorView!
    @IBOutlet weak var searchRecipes: UIButton!
    
    // MARK: - Actions
    
    @IBAction func addIngredient(_ sender: UIButton) {
        if ingredient.text != "" {
            ingredients.append(ingredient.text!)
            listOfIngredients.text = "- " + ingredients.joined(separator: "\n- ")
            ingredient.text = ""
        } else {
            alert(title: "Erreur !", message: "Veuillez ajouter un ingrédient")
        }
    }
    
    @IBAction func clearIngredient(_ sender: UIButton) {
        let clearAlert = UIAlertController(title: "Clear", message: "Do you want to remove all the ingredients ?", preferredStyle: .alert)
        clearAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.ingredients.removeAll()
            self.listOfIngredients.text = ""
        }))
        clearAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(clearAlert, animated: true, completion: nil)
    }
    
    @IBAction func searchForRecipes(_ sender: UIButton) {
        activityIndicator(activityIndicator: searchActivity, button: searchRecipes, showActivityIndicator: true)
        recipeService.request(from: 0, to: 20, ingredients: ingredients, completionHandler: { (recipe, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.dataRecipe = recipe
                    self.recipes = recipe!.hits
//                    self.dataRecipe = recipe
//                    self.recipes = self.dataRecipe!.hits
                    self.performSegue(withIdentifier: "SearchToResult", sender: nil)
                } else {
                    self.alert(title: "Erreur", message: "Veuillez vérifier les informations renseignées et votre connexion !")
                }
                self.activityIndicator(activityIndicator: self.searchActivity, button: self.searchRecipes, showActivityIndicator: false)
            }
        })
    }
    
    // MARK: - View life cycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dataController = segue.destination as? SearchResultViewController {
            dataController.dataRecipe = dataRecipe
            dataController.ingredients = ingredients
            dataController.recipes = recipes
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfIngredients.delegate = self
        activityIndicator(activityIndicator: self.searchActivity, button: self.searchRecipes, showActivityIndicator: false)
        initializeHideKeyboard()
    }
}
