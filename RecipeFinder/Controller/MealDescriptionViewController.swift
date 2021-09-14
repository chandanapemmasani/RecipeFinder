//
//  MealDescriptionViewController.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/5/21.
//

import UIKit

protocol fetchMealDesc: AnyObject {
    func fetchMealDescription(_ meal: [String: Any])
}

class MealDescriptionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, fetchMealDesc {
    
    
    @IBOutlet weak var ingredientsTV: UITableView!
    
    @IBOutlet weak var mealName: UILabel!
    
    
    @IBOutlet weak var mealID: UILabel!
    
    @IBOutlet weak var mealCategory: UILabel!
    
    @IBOutlet weak var mealLocation: UILabel!
    
    @IBOutlet weak var mealImg: UIImageView!
    
    @IBOutlet weak var imgSource: UILabel!
    
    @IBOutlet weak var youtubeLinkLbl: UILabel!
    
    
    var mealDesc = [[String:Any]]()
    var meal = [String:Any?]()
    var ingridientCount = 0
    
    weak var instructionsDel: MealInstructions!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func mealDescriptionAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MealInstructionsViewController") as? MealInstructionsViewController else {
            
            return
        }
        controller.instructionList = meal
        
        self.present(controller, animated: true, completion: nil)
        
    }
 
    
    
    func fetchMealDescription(_ meal: [String: Any]) {


                self.mealDesc =  meal["meals"] as! [[String : Any]]
                self.meal = self.mealDesc[0]

                for (key, value) in  self.meal  {
                    if key.contains("strIngredient") {
                        if value as? String != "" {
                            self.ingridientCount = self.ingridientCount + 1
                        }

                    }
                }

                let imgString = self.meal["strMealThumb"] as? String

                if let str = imgString {
                    if let image = self.getImage(from: str) {

                        self.mealImg?.image = image

                    }

                }


                DispatchQueue.main.async {
                    self.mealID.text = self.meal["idMeal"] as? String
                    self.mealName.text = self.meal["strMeal"] as? String
                    self.mealLocation.text = self.meal["strArea"] as? String
                    self.mealCategory.text = self.meal["strCategory"] as? String
                    if let source = self.meal["strImageSource"] as? String {
                        self.imgSource.text = "Image Source: \(source)"
                    }
                    else {
                        self.imgSource.text = "Image source not available"
                    }
                    if let source = self.meal["strYoutube"] as? String {
                        if source != "" {
                            self.youtubeLinkLbl.text = "Youtube: \(source)"
                        }
                    }
                    else {
                        self.youtubeLinkLbl.text = "Youtube link not available"
                    }


                    self.ingredientsTV.reloadData()
                }


            
        }
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingridientCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ingredientsTV.dequeueReusableCell(withIdentifier: "ingedientsCell", for: indexPath) as! ingedientsCell
        let ingridientString = "strIngredient\(indexPath.row + 1)"
        let quantityString = "strMeasure\(indexPath.row + 1)"
        
        for (key, value) in  self.meal  {
            
            if key == ingridientString {
                if value as? String != ""{
                    cell.ingridientName.text = value as? String
                }
                
            }
            if key == quantityString {
                if value as? String != "" {
                    cell.ingridientQnty.text = value as? String
                }
                
            }
        }
        
        return cell
        
    }
    
    
}
