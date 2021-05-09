//
//  Recipe.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import Foundation
import Firebase

class Recipe {
    var name: String
    var ingredients: String
    var instructions: String
    var reviewUserID: String
    var documentID: String
    var rating: Int
    
    var dictionary: [String: Any] {
        return ["name": name, "ingredients": ingredients, "instructions": instructions, "rating": rating, "reviewUserID": reviewUserID]
    }
    
    init (name: String, ingredients: String, rating: Int, reviewUserID: String, instructions: String, documentID: String) {
        self.name = name
        self.ingredients = ingredients
        self.rating = rating
        self.instructions = instructions
        self.reviewUserID = reviewUserID
        self.documentID = documentID
    }
    
    convenience init() {
        let reviewUserID = Auth.auth().currentUser?.uid ?? ""
        let reviewUserEmail = Auth.auth().auth().currentUser?.email ?? ""
        self.init (name: "", ingredients: "", rating: 0, instructions: "", reviewUserID: reviewUserID, documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        // working with a dictionary where key is a string
        let name = dictionary["name"] as! String? ?? ""
        let ingredients = dictionary["ingredients"] as! String? ?? ""
        let rating = dictionary["rating"] as! Int? ?? 0
        let instructions = dictionary["instructions"] as! String? ?? ""
        let reviewUserID = dictionary["reviewUserID"] as! String? ?? ""
        let documentID = dictionary["documentID"] as! String? ?? ""
        
        self.init (name: name, ingredients: ingredients, instructions: instructions, rating: rating, reviewUserID: reviewUserID, documentID: documentID)

    }
}
