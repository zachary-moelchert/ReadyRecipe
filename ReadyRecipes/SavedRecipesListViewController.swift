//
//  SavedRecipesViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class SavedRecipesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    var dummyData = ["Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here"]
   
    var savedRecipesArray: [Recipe] = []
    var recipes: Recipes!
    var weekDay: String!
    var weeklyDictionary: [String: Recipe] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        for recipe in recipes.savedRecipeArray {
//            if recipe.saved {
//                savedRecipesArray.append(recipe)
//            }
//        }
        tableView.delegate = self
        tableView.dataSource = self
        
        
        loadData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SavedRecipeDetailViewController
        if weekDay != nil {
            destination.weekDay = weekDay
        } else {
            destination.addRecipeButton?.isEnabled = false
        }
    }
    
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("savedRecipes").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            savedRecipesArray = try jsonDecoder.decode(Array.self, from: data)
            tableView.reloadData()
        } catch {
            print("ERROR: could not load data")
        }
    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("savedRecipes").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(savedRecipesArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("ERROR: could not save data")
        }
    }
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        // check identifier?
        let source = segue.source as! SavedRecipeDetailViewController
        weeklyDictionary = source.weeklyDictionary
        saveData()
    }

}

extension SavedRecipesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRecipesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedRecipeCell", for: indexPath)
        cell.textLabel?.text = savedRecipesArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedRecipesArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = savedRecipesArray[sourceIndexPath.row]
        savedRecipesArray.remove(at: sourceIndexPath.row)
        savedRecipesArray.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
