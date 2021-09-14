//
//  MealsTableViewCell.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/5/21.
//

import UIKit

class MealsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealsImg: UIImageView!
    
    @IBOutlet weak var mealName: UILabel!
    
    @IBOutlet weak var mealID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
