//
//  Categories.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/13/21.
//

import Foundation

public class Categories : Decodable {
    
    public var categories: [Category]?
    
    private enum CodingKeys: String, CodingKey {
        case categories
    }

    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.categories = try container.decodeIfPresent([Category].self, forKey: .categories)
    }
}
