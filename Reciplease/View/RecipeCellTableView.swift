//
//  RecipeCellTableView.swift
//  Reciplease
//
//  Created by HappyVolt on 31/05/2024.
//

import UIKit

class RecipeCellTableView: UITableViewCell {

    
        // MARK: - Outlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet  var recipeTitle: UILabel!
//    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    // MARK: - View life cycle
    
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
    
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
    
        }
    
        override func prepareForReuse() {
            super.prepareForReuse()
            recipeImage.removeAllGradientLayerInForeground()
        }
    
    }
