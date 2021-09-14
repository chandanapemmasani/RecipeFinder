//
//  Meal.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/13/21.
//

import Foundation

public class Meal: Decodable {
    
    public var strMeal: String?
    
    public var strMealThumb: String?
    
    public var idMeal: String?
    
   
    private enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }


    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.strMeal = try container.decodeIfPresent(String.self, forKey: .strMeal)
        self.strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        self.idMeal = try container.decodeIfPresent(String.self, forKey: .idMeal)
       
    }
}
