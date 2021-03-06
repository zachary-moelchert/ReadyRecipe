//
//  CalendarDetailViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/14/21.
//

import UIKit

class CalendarDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var addRecipeButton: UIBarButtonItem!
    @IBOutlet weak var instructionsTextView: UITextView!

    var recipe: Recipe!
    var weekDay: String!
    var weeklyDictionary: [String: Recipe] = [:]
    var photo: Photo!

    override func viewDidLoad() {
        super.viewDidLoad()

        if recipe == nil {
            recipe = Recipe()
        }
        if photo == nil {
            photo = Photo()
        }
        
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
//        self.addPhotoButton.isHidden = true
        
        updateUserInterface()
    }
    
    func updateUserInterface() {
//        self.recipe = weeklyDictionary[weekDay] ?? Recipe()
        nameLabel?.text = weeklyDictionary[weekDay]?.name
        ingredientsTextView?.text =  weeklyDictionary[weekDay]?.ingredients
        instructionsTextView?.text =  weeklyDictionary[weekDay]?.instructions
//        photoImageView?.image = weeklyDictionary[weekDay]?.
    }
    
    func updateFromUserInterface() {
        recipe.name = nameLabel.text!
        recipe.ingredients = ingredientsTextView.text!
        recipe.instructions = instructionsTextView.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! RecipeListViewController
        destination.weekDay = weekDay
        destination.weeklyDictionary = weeklyDictionary
    }
    
    
    
    // Save button pressed function
    
//    updateFromInterface()
//    review.saveData { (success) in
//        if success {
//            self.leaveViewController()
//        } else {
//            // ERROR during save occurred
//            self.oneButtonAlert(title: "Save Failed", message: "For some reason, the data would not save to the cloud.")
//        }
//    }

}
