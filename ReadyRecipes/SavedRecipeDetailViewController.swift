//
//  SavedRecipeDetailViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/14/21.
//

import UIKit

class SavedRecipeDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var addRecipeButton: UIBarButtonItem!
    
    
    var weekDay: String!
    var weeklyDictionary: [String: Recipe] = [:]
    var recipe: Recipe!
   
    override func viewDidLoad() {
        super.viewDidLoad()

//        if weekDay == nil {
//            weekDay = ""
//        }
//
        
//        guard weekDay != nil else {
//            print("ERROR: No weekDay passed to SavedRecipeDetailController.swift")
//            return
//        }
        
        
        guard recipe != nil else {
            print("ERROR: No recipe passed to SavedRecipeDetailViewController")
            return
        }
        print("------------- WEEKDAY = \(weekDay) -----------------")

        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameLabel.text = recipe.name
        instructionsTextView.text = recipe.instructions
        ingredientsTextView.text = recipe.ingredients
    }
    
    


    @IBAction func addRecipePressed(_ sender: UIBarButtonItem) {
        
        
        
        
    }
    
}
