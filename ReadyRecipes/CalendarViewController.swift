//
//  ViewController.swift
//  ReadyRecipes
//
//  Created by Zachary Moelchert on 5/8/21.
//

import UIKit

class CalendarViewController: UIViewController {

    var dummyData = ["Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here", "Recipe here"]
    var daysOfTheWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var weeklyRecipeSchedule: [Recipe] = []
    var recipes: Recipes!
    var weekDay = ""
    var weeklyDictionary: [String: Recipe] = [:]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CalendarDetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        destination.weeklyDictionary = weeklyDictionary
       
        switch selectedIndexPath {
        case IndexPath(index: 0):
            self.weekDay = daysOfTheWeek[0]
            destination.weekDay = weekDay
        case IndexPath(index: 1):
            self.weekDay = daysOfTheWeek[1]
            destination.weekDay = weekDay
        case IndexPath(index: 2):
            self.weekDay = daysOfTheWeek[2]
            destination.weekDay = weekDay
        case IndexPath(index: 3):
            self.weekDay = daysOfTheWeek[3]
            destination.weekDay = weekDay
        case IndexPath(index: 4):
            self.weekDay = daysOfTheWeek[4]
            destination.weekDay = weekDay
        case IndexPath(index: 5):
            self.weekDay = daysOfTheWeek[5]
            destination.weekDay = weekDay
        case IndexPath(index: 6):
            self.weekDay = daysOfTheWeek[6]
            destination.weekDay = weekDay
        default:
            print("ERROR: preparing for segue and assigning day of the week")
//            destination.weekDay = "Sunday"
        }
        
        
    }

 

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyCell", for: indexPath) as! CalendarCell
        cell.recipeNameLabel?.text = dummyData[indexPath.row]
        cell.dayOfWeekLabel?.text = daysOfTheWeek[indexPath.row]
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
        return 100
    }
}


