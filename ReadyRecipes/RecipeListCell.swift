//
//  RecipeListTableViewCell.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class RecipeListCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var recipe: Recipe! {
        didSet {
            nameLabel.text = recipe.name
        }
    }
    var photo: Photo! {
        didSet {
            if let url = URL(string: self.photo.photoURL) {
                self.photoImageView.sd_imageTransition = .fade
                self.photoImageView.sd_imageTransition?.duration = 0.2
                self.photoImageView.sd_setImage(with: url)
            } else {
                print("URL Didn't work \(self.photo.photoURL)")
                self.photo.loadImage(recipe: self.recipe) { (success) in
                    self.photo.saveData(recipe: self.recipe) { (success) in
                        print("Image updated with URL \(self.photo.photoURL)")
                    }
                }
            }
        }
    }
    

}
