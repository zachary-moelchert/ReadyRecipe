//
//  RecipeDetailViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var recipeNameTextView: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    var recipe: Recipe!
    var weeklyDictionary: [String: Recipe] = [:]
    var weekDay: String!
    var photo: Photo!
    var imagePickerController = UIImagePickerController()
    
    
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
        imagePickerController.delegate = self
        
        
        updateUserInterface()
    }
    
    func updateUserInterface() {
        recipeNameTextView?.text = ""
        ingredientsTextView?.text = recipe.ingredients
        instructionsTextView?.text = recipe.instructions
        imageView?.image = photo.image
    }
    
    func updateFromUserInterface() {
        recipe.name = recipeNameTextView.text!
        recipe.ingredients = ingredientsTextView.text!
        recipe.instructions = instructionsTextView.text!
        photo.image = imageView.image!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        performSegue(withIdentifier: "AddPhoto", sender: nil)
        if segue.identifier == "AddPhoto" {
            updateFromUserInterface()
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.viewControllers.first as! PhotoViewController
            destination.photo = photo
            destination.recipe = recipe
//            if (recipeNameTextView.text != nil) {
//                destination.foodNameLabel?.text = recipeNameTextView.text
//            }
        } else {
            updateFromUserInterface()
            //            let destination = segue.destination as! RecipeListViewController
            //            destination.recipes.recipeArray.append(self.recipe)
        }
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
    
    func showAlert(alertTitle: String, message: String) {
        let alertController = UIAlertController(title: alertTitle, message:  message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func cameraOrLibraryAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            self.accessPhotoLibrary()
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.accessCamera()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func addPhotoPressed(_ sender: UIButton) {
        cameraOrLibraryAlert()
    }
}

extension RecipeDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        photo = Photo()
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photo.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photo.image = originalImage
        }
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "AddPhoto", sender: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessPhotoLibrary() {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func accessCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
            
        } else {
            self.oneButtonAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
        }
    }
}
