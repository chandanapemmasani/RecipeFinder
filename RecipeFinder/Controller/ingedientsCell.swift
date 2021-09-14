//
//  ingedientsCell.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/5/21.
//

import UIKit

class ingedientsCell: UITableViewCell {
    
    
    @IBOutlet weak var ingridientName: UILabel!
    
    @IBOutlet weak var ingridientQnty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
