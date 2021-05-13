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
    var recipeUserID: String
//    var posterUserID: String   ------ is this the same as recipeUserID ???
    var documentID: String
    var rating: Int
    var saved: Bool
    
    var dictionary: [String: Any] {
        return ["name": name, "ingredients": ingredients, "instructions": instructions, "rating": rating, "recipeUserID": recipeUserID, "saved": saved]
    }
    
    init (name: String, ingredients: String, rating: Int, recipeUserID: String, instructions: String, documentID: String, saved: Bool) {
        self.name = name
        self.ingredients = ingredients
        self.rating = rating
        self.instructions = instructions
        self.recipeUserID = recipeUserID
        self.documentID = documentID
        self.saved = saved
    }
    
    convenience init() {
        let reviewUserID = Auth.auth().currentUser?.uid ?? ""
        let reviewUserEmail = Auth.auth().currentUser?.email ?? ""
        self.init (name: "", ingredients: "", rating: 0, recipeUserID: "", instructions: "", documentID: "", saved: false)
    }
    
    convenience init(dictionary: [String: Any]) {
        // working with a dictionary where key is a string
        let name = dictionary["name"] as! String? ?? ""
        let ingredients = dictionary["ingredients"] as! String? ?? ""
        let rating = dictionary["rating"] as! Int? ?? 0
        let instructions = dictionary["instructions"] as! String? ?? ""
        let recipeUserID = dictionary["recipeUserID"] as! String? ?? ""
        let documentID = dictionary["documentID"] as! String? ?? ""
        let saved = dictionary["saved"] as! Bool? ?? false
        self.init(name: name, ingredients: ingredients, rating: rating, recipeUserID: recipeUserID, instructions: instructions, documentID: documentID, saved: saved)
    }
    
    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let postingUserID = Auth.auth().currentUser?.uid else {
            print("ERROR: Could not save data")
            return completion(false)
        }
        
        
        
//        self.postingUserID = postingUserID
//        self.recipeUserID = recipeUserID
        
        
        
        
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // if we have a saved record, we'll have an ID, otherwise .addDocument will create one.
        if self.documentID == "" { // Create a new document
            var ref: DocumentReference? = nil // Firestore will create a new one
            ref = db.collection("recipes").addDocument(data: dataToSave){ (error) in
                guard error == nil else {
                    print("ERROR: Could not save data")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("Added document: \(self.documentID)")
                completion(true)
            }
        } else { // else save to the existing documentID with .setData
            let ref = db.collection("recipes").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("ERROR updating document")
                    return completion(false)
                }
                print("Added document: \(self.documentID)")
                completion(true)
            }
        }
    }
}
