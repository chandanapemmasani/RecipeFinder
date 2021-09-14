//
//  MealInstructionsViewController.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/6/21.
//

import UIKit

protocol MealInstructions: AnyObject {
    func mealInstructionsList(_ instructionObject: [String:Any?])
}


class MealInstructionsViewController: UIViewController, MealInstructions {
    
    
    
    @IBOutlet weak var dateModifiedlBL: UILabel!
    
    
    @IBOutlet weak var instructionsTextField: UITextView!
    
    @IBOutlet weak var commonsLbl: UILabel!
    
    @IBOutlet weak var tagsLbl: UILabel!
    
    @IBOutlet weak var drinkslBL: UILabel!
    
    @IBOutlet weak var sourceLbl: UILabel!
    
    var instructionList = [String:Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealInstructionsList(instructionList)
        // Do any additional setup after loading the view.
    }
    
    func mealInstructionsList(_ instructionObject: [String : Any?]) {
        
        instructionsTextField.text = instructionObject["strInstructions"] as? String
        
        if let lbl = instructionObject["dateModified"] as? String {
            if lbl != "" {
                dateModifiedlBL.text = "Date modified: \(lbl)"
            }
        }
        
        else {
            dateModifiedlBL.text = "Date unavailable"
        }
        
        if let lbl = instructionObject["strCreativeCommonsConfirmed"] as? String {
            if lbl != "" {
                commonsLbl.text = lbl
            }
        }
        
        else {
            commonsLbl.text = "Creative Commons data unavailable"
        }
        
        if let lbl = instructionObject["strSource"] as? String {
            if lbl != "" {
                sourceLbl.text = "Source: \(lbl)"
            }
        }
        
        else {
            sourceLbl.text = "Source unavailable"
        }
        
        if let lbl = instructionObject["strTags"] as? String {
            if lbl != "" {
                tagsLbl.text = "Tag: \(lbl)"
            }
        }
        
        else {
            tagsLbl.text = "Tag unavailable"
        }
        
        if let lbl = instructionObject["strDrinkAlternate"] as? String {
            if lbl != "" {
                drinkslBL.text = "Alternate: \(lbl)"
            }
        }
        
        else {
            drinkslBL.text = "Alternate Drink unavailable"
        }
        
    }
    
}
