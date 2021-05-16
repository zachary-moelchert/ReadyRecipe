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
    var photo: Photo!
   
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
        
        if photo == nil {
            photo = Photo()
        }
        
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
        photoImageView?.image = photo.image
        saveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReturnToCalendar" {
            let destination = segue.destination as! CalendarViewController
            weeklyDictionary[weekDay] = recipe
            destination.weeklyDictionary = weeklyDictionary
            destination.photo = self.photo
        }
        saveData()
    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("weeklyDictionary").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(weeklyDictionary)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("ERROR: Could not save data")
        }
    }


    
}
