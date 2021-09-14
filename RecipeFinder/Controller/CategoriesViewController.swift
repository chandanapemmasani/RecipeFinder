//
//  CategoriesViewController.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/4/21.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    @IBOutlet weak var categoryTableview: UITableView!
    
        weak var delegate: fetchMeals!
        
        var categories: Categories? {
          didSet {
            if isViewLoaded {
                categoryTableview.reloadData()
            }
          }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = categoryTableview.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        
        let category = categories?.categories?[indexPath.row]
        
        cell.categoryName.text = category?.strCategory
        
        cell.categoryDescription.text = category?.strCategoryDescription
        
        
        let imgString = category?.strCategoryThumb
        
        if let str = imgString {
            if let image = getImage(from: str) {
                
                cell.categoryimg?.image = image
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MealsViewController") as? MealsViewController else {
            return
        }
        
        self.delegate = controller
        let cell = categoryTableview.cellForRow(at: indexPath) as? CategoryTableViewCell
        if  let catName = cell?.categoryName.text {
            NetworkManager.fetchMeals(catName){ (meals, success) in
                if success == true {
                    self.delegate.fetchMealsDelegate(meals)
                }
              }
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
