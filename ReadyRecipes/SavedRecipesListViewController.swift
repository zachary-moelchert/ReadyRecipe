//
//  SavedRecipesViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class SavedRecipesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dummyData = ["Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here"]
   
    var savedRecipesArray: [Recipe] = []
    var recipes: Recipes!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        for recipe in recipes.savedRecipeArray {
//            if recipe.saved {
//                savedRecipesArray.append(recipe)
//            }
//        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension SavedRecipesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedRecipeCell", for: indexPath)
        cell.textLabel?.text = dummyData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dummyData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = dummyData[sourceIndexPath.row]
        dummyData.remove(at: sourceIndexPath.row)
        dummyData.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
