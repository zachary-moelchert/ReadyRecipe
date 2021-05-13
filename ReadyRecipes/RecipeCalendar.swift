//
//  RecipeCalendar.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/11/21.
//

import Foundation
import Firebase

class RecipeCalendar {
    
    var weeklyRecipeSchedule: [Recipe] = []
    var recipe: Recipe!
    
    var dictionary: [String: Recipe] {
        return ["Sunday": recipe, "Monday": recipe, "Tuesday": recipe, "Wednesday": recipe, "Thursday": recipe, "Friday": recipe, "Saturday": recipe]
    }
//
//    init (Sunday: Recipe, Monday: Recipe, Tuesday: Recipe, Wednesday: Recipe, Thursday: Recipe, Friday: Recipe, Saturday: Recipe) {
//        self.sunday = name
//        self.ingredients = ingredients
//        self.rating = rating
//        self.instructions = instructions
//        self.reviewUserID = reviewUserID
//        self.documentID = documentID
//    }
//
//    convenience init() {
//        let reviewUserID = Auth.auth().currentUser?.uid ?? ""
//        let reviewUserEmail = Auth.auth().currentUser?.email ?? ""
//        self.init (name: "", ingredients: "", rating: 0, reviewUserID: reviewUserID, instructions: "", documentID: "")
//    }
//
//    convenience init(dictionary: [String: Any]) {
//        // working with a dictionary where key is a string
//        let name = dictionary["name"] as! String? ?? ""
//        let ingredients = dictionary["ingredients"] as! String? ?? ""
//        let rating = dictionary["rating"] as! Int? ?? 0
//        let instructions = dictionary["instructions"] as! String? ?? ""
//        let reviewUserID = dictionary["reviewUserID"] as! String? ?? ""
//        let documentID = dictionary["documentID"] as! String? ?? ""
//        self.init(name: name, ingredients: ingredients, rating: rating, reviewUserID: reviewUserID, instructions: instructions, documentID: documentID)
//    }

}
