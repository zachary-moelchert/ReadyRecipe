//
//  ViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class CalendarViewController: UIViewController {

//    var dummyData = ["Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here"]
    var daysOfTheWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var weeklyRecipeSchedule: [Recipe] = []
    var recipes: Recipes!
    var weekDay = ""
    var weeklyDictionary: [String: Recipe] = [:]
    var photo: Photo!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CalendarDetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        destination.weeklyDictionary = weeklyDictionary
       
        switch selectedIndexPath {
        case IndexPath(row: 0, section: 0):
            self.weekDay = daysOfTheWeek[0]
            destination.weekDay = weekDay
        case IndexPath(row: 1, section: 0):
            self.weekDay = daysOfTheWeek[1]
            destination.weekDay = weekDay
        case IndexPath(row: 2, section: 0):
            self.weekDay = daysOfTheWeek[2]
            destination.weekDay = weekDay
        case IndexPath(row: 3, section: 0):
            self.weekDay = daysOfTheWeek[3]
            destination.weekDay = weekDay
        case IndexPath(row: 4, section: 0):
            self.weekDay = daysOfTheWeek[4]
            destination.weekDay = weekDay
        case IndexPath(row: 5, section: 0):
            self.weekDay = daysOfTheWeek[5]
            destination.weekDay = weekDay
        case IndexPath(row: 6, section: 0):
            self.weekDay = daysOfTheWeek[6]
            destination.weekDay = weekDay
        default:
            print("ERROR: preparing for segue and assigning day of the week")
        }
        
    }

    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("weeklyDictionary").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        do {
            weeklyDictionary = try jsonDecoder.decode(Dictionary.self, from: data)
            tableView.reloadData()
        } catch {
            print("ERROR: Could not load data")
        }
    }

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyCell", for: indexPath) as! CalendarCell
       
        if weeklyDictionary[daysOfTheWeek[indexPath.row]]?.name == nil {
            cell.recipeNameLabel?.text = "Click to add recipe"
        } else {
            cell.recipeNameLabel?.text = weeklyDictionary[daysOfTheWeek[indexPath.row]]?.name
        }
       
        cell.photoImageView?.image = photo?.image
        cell.dayOfWeekLabel?.text = daysOfTheWeek[indexPath.row]
        
        
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
        return 100
    }
}


