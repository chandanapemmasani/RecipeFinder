//
//  CategoryTableViewCell.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/4/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryimg: UIImageView!
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
