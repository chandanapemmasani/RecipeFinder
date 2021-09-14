//
//  MealsViewController.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/5/21.
//

import UIKit
protocol fetchMeals: AnyObject {
    
    func fetchMealsDelegate(_ mealsList: Meals?)
}

class MealsViewController: UIViewController, fetchMeals, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchMeals: UISearchBar!
    @IBOutlet weak var mealsTableview: UITableView!
    
    
    
    var searchMealID = [String]()
    var searching = false
    var mealsList: Meals?
    var mealIDs = [String]()
    weak var mealDel: fetchMealDesc!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFieldInsideSearchBar = self.searchMeals.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = .black
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchMealID = self.mealIDs.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        self.mealsTableview.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.mealsTableview.reloadData()
    }
    
    func fetchMealsDelegate(_ mealsList: Meals?) {
        
        self.mealsList =  mealsList
        self.getMealNames()
        DispatchQueue.main.async {
            self.mealsTableview.reloadData()
        }
        
        
    }
    
    func getMealNames() {
        if let mealCount = mealsList?.meals?.count {
            for i in 0..<mealCount{
                if let mealName = mealsList?.meals?[i].idMeal {
                    mealIDs.append(mealName)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searching {
            return searchMealID.count
        }
        else{
            return mealsList?.meals?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mealsTableview.dequeueReusableCell(withIdentifier: "MealsTableViewCell", for: indexPath) as! MealsTableViewCell
        
        var allMeals = [Meal]()
        if let meals = mealsList?.meals {
        if searching{
            
            for id in searchMealID {
                for meal in meals {
                    if let mealId = meal.idMeal {
                        if id == mealId {
                            allMeals.append(meal)
                        }
                    }
                }
            }
        }
        
        else {
            for meal in meals {
                allMeals.append(meal)
            }
            
        }
        }
        let category = allMeals[indexPath.row]
        
        cell.mealID.text = category.idMeal
        
        cell.mealName.text = category.strMeal
        
        
        let imgString = category.strMealThumb
        
        if let str = imgString {
            if let image = getImage(from: str) {
                
                cell.imageView?.image = image
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MealDescriptionViewController") as? MealDescriptionViewController else {
            return
        }
        
        self.mealDel = controller
        let cell = mealsTableview.cellForRow(at: indexPath) as? MealsTableViewCell
        if  let id = cell?.mealID.text {
            NetworkManager.fetchMealbyID(id){ (meal, success) in
                if success == true {
                    if let meal = meal {
                    self.mealDel.fetchMealDescription(meal)
                    }
                }
              }
            
        }
        
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension UIViewController {
    public func getImage(from string: String) -> UIImage? {
        guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
        }
        
        var image: UIImage? = nil
        do {
            let data = try Data(contentsOf: url, options: [])
            
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return image
    }
}
