//
//  CalendarCell.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit
import SDWebImage

class CalendarCell: UITableViewCell {
    
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var recipe: Recipe! {
        didSet {
            dayOfWeekLabel.text = "Sunday"
            recipeNameLabel.text = recipe.name
            
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
