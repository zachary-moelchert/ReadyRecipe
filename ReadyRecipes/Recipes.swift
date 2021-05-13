//
//  Recipes.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/9/21.
//

import Foundation
import Firebase

class Recipes {
    
    var savedRecipeArray: [Recipe] = []
    var db: Firestore!

    init() {
        db = Firestore.firestore()
    }
    
    func loadData(recipe: Recipe, completed: @escaping () -> ()) {
        guard recipe.documentID != "" else {
            return
        }
        db.collection("recipes").document(recipe.documentID).collection("fullList").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error?.localizedDescription)")
                return completed()
            }
            self.savedRecipeArray = [] // clean out existing spotArray since new data will load
            // there are queryShapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                // make sure you have a dictionary initializer
                let recipe = Recipe(dictionary: document.data())
                recipe.documentID = document.documentID
                self.savedRecipeArray.append(recipe)
            }
            completed()
        }
    }
}

