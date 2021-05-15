//
//  RecipeListViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class RecipeListViewController: UIViewController {
    
//    var dummyData = ["Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here"]
    var recipes: Recipes!
    var weeklyDictionary: [String: Recipe] = [:]

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if recipes == nil {
            recipes = Recipes()
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowRecipe" {
            let destination = segue.destination as! RecipeDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
//            destination.recipe = recipes.savedRecipeArray[selectedIndexPath.row]
            destination.addPhotoButton?.isHidden = true
            destination.weekDay = ""
        } else if segue.identifier == "AddRecipe" {
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.viewControllers.first as! RecipeDetailViewController
            destination.addPhotoButton?.isHidden = false
        }
    }
    
//    func loadData() {
//        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let documentURL = directoryURL.appendingPathComponent("recipes").appendingPathExtension("json")
//        guard let data = try? Data(contentsOf: documentURL) else {return}
//        let jsonDecoder = JSONDecoder()
//        do {
//            recipes = try jsonDecoder.decode(Array<Any>.self, from: data)
//            tableView.reloadData()
//        } catch {
//            print("ERROR: could not load data")
//        }
//    }
//
//    func saveData() {
//        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let documentURL = directoryURL.appendingPathComponent("recipes").appendingPathExtension("json")
//        let jsonEncoder = JSONEncoder()
//        let data = try? jsonEncoder.encode(recipes)
//        do {
//            try data?.write(to: documentURL, options: .noFileProtection)
//        } catch {
//            print("ERROR: could not save data")
//        }
//    }
    
    @IBAction func undwindFromRecipeDetail(segue: UIStoryboardSegue) {
        // check identifier?
        let source = segue.source as! RecipeDetailViewController
        recipes.recipeArray.append(source.recipe)
        tableView.reloadData()
//        saveData()
    }
    
}

//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        updateFromInterface()
//        switch segue.identifier ?? "" {
//        case "SavedRecipeSegue":
//            let destination = segue.destination as! SavedRecipesListViewController
//            let selectedIndexPath = tableView.indexPathForSelectedRow!
//            destination.recipe = recipes.savedRecipeArray[selectedIndexPath.row]
//        case "ShowRecipe":
//            let destination = segue.destination as! RecipeDetailViewController
//            let selectedIndexPath = tableView.indexPathForSelectedRow!
//            destination.recipe = recipes.savedRecipeArray[selectedIndexPath.row]
//        default:
//            print("Couldn't find a case for segue identifier \(segue.identifier)")
//        }
//    }
//


//    @IBAction func unwindFromRecipeDetailViewController(segue: UIStoryboardSegue) {
//        let source = segue.source as! RecipeDetailViewController
//        let pageViewController = UIApplication.shared.windows.first!.rootViewController as! PageViewController
//        pageViewController.weatherLocations = source.weatherLocations
//        pageViewController.setViewControllers([pageViewController.createLocationDetailViewController(forPage: locationIndex)], direction: .forward, animated: false, completion: nil)
//    }
//


extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeListCell", for: indexPath) as! RecipeListCell
        cell.nameLabel?.text = recipes.recipeArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            recipes.recipeArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = recipes.recipeArray[sourceIndexPath.row]
        recipes.recipeArray.remove(at: sourceIndexPath.row)
        recipes.recipeArray.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
