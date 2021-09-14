//
//  Meals.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/13/21.
//

import Foundation

public class Meals : Decodable {
    
    public var meals: [Meal]?
    
    private enum CodingKeys: String, CodingKey {
        case meals
    }

    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.meals = try container.decodeIfPresent([Meal].self, forKey: .meals)
    }
}
