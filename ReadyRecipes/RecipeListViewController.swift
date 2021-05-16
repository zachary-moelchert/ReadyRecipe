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
    var weekDay: String!

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if recipes == nil {
            recipes = Recipes()
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowSavedRecipe" {
            let destination = segue.destination as! SavedRecipeDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            if self.weekDay != nil {
                destination.weekDay = self.weekDay
            }
            destination.addRecipeButton?.isEnabled = false
            destination.recipe = recipes.recipeArray[selectedIndexPath.row]
        } else if segue.identifier == "AddRecipe" {
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.viewControllers.first as! RecipeDetailViewController
            destination.addPhotoButton?.isHidden = false
        }
//        else if segue.identifier == "ShowSavedRecipe"

    }
    
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("recipes").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            recipes.recipeArray = try jsonDecoder.decode(Array.self, from: data)
            tableView.reloadData()
        } catch {
            print("ERROR: could not load data")
        }
    }

    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("recipes").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(recipes.recipeArray)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("ERROR: could not save data")
        }
    }
    
    @IBAction func unwindFromRecipeDetail(segue: UIStoryboardSegue) {
        // check identifier?
        let source = segue.source as! RecipeDetailViewController
        recipes.recipeArray.append(source.recipe)
        saveData()
        tableView.reloadData()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
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
