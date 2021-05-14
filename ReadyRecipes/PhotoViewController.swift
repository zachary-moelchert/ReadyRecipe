//
//  PhotoViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/9/21.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!

    var photo: Photo!
    var recipe: Recipe!
    var recipeName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard recipe != nil else {
            print("ERROR: No recipe passed to PhotoViewController.swift")
            return
        }
        
        guard photo != nil else {
            print("ERROR: No photo passed to PhotoViewController.swift")
            return
        }
        
        updateUserInterface()
    }
    
    func updateUserInterface() {
        foodNameLabel.text = recipe.name
        photoImageView.image = photo.image
        
        guard let url = URL(string: photo.photoURL) else {
            // Then this must be a mew image -- get the image from the photo.image passed in rather than from the url
            photoImageView.image = photo.image
            return
        }
        photoImageView.sd_imageTransition = .fade
        photoImageView.sd_imageTransition?.duration = 0.5
        photoImageView.sd_setImage(with: url)
    }
    
    func updateFromUserInterface() {
//        photo.description = descriptionTextView.text!
        photo.image = photoImageView.image!
    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateFromUserInterface()
        photo.saveData(recipe: recipe) { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("ERROR: can't unwind from PhotoViewController because of photo saving error")
            }
        }
    }
    
}
