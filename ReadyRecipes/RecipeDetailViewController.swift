//
//  RecipeDetailViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    var recipe: Recipe!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if recipe == nil {
            recipe = Recipe()
        }
        
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
//        self.addPhotoButton.isHidden = true
        
        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameLabel?.text = ""
        ingredientsTextView?.text = "Ingredients here"
        instructionsTextView?.text = "Instructions here"
    }
    
    func updateFromUserInterface() {
        recipe.name = nameLabel.text!
        recipe.ingredients = ingredientsTextView.text!
        recipe.instructions = instructionsTextView.text!
        
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

    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func addPhotoPressed(_ sender: UIButton) {
    }
    


}
