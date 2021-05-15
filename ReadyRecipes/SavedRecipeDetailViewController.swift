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
    
    
    var weekDay = ""
    var weeklyDictionary: [String: Recipe] = [:]

    
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
        
        print("------------- WEEKDAY = \(weekDay) -----------------")

    }
    


    @IBAction func addRecipePressed(_ sender: UIBarButtonItem) {
 
    }
    
}
