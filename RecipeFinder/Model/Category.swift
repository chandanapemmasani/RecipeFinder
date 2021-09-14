
//
//  Category.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/13/21.
//

import Foundation

public class Category: Decodable {
    
    public var idCategory: String?
    
    public var strCategory: String?
    
    public var strCategoryThumb: String?
    
    public var strCategoryDescription: String?
    
   
    private enum CodingKeys: String, CodingKey {
        case idCategory
        case strCategory
        case strCategoryThumb
        case strCategoryDescription
       
    }


    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idCategory = try container.decodeIfPresent(String.self, forKey: .idCategory)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.strCategoryThumb = try container.decodeIfPresent(String.self, forKey: .strCategoryThumb)
        self.strCategoryDescription = try container.decodeIfPresent(String.self, forKey: .strCategoryDescription)
    }
}
