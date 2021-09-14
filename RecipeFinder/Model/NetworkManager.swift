//
//  NetworkManager.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/13/21.
//

import Foundation



class NetworkManager: ObservableObject {
    
    
    static func fetchCategories(completionHandler: @escaping (Categories?, Bool?) -> Void) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        let request = NetworkRequest(url: url)
        request.execute {  (data) in
            if let data = data {
                do {
                    let categoriesListed: Categories? = try JSONDecoder().decode(Categories.self, from: data)
                    completionHandler(categoriesListed, true)
                } catch {
                    print("error")
                    completionHandler(nil, false)
                }
                
            }
            else {
                completionHandler(nil, false)
            }
        }
    }
    
    static func fetchMeals(_ categoryName: String, completionHandler: @escaping (Meals?, Bool?) -> Void) {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categoryName)")!
        let request = NetworkRequest(url: url)
        request.execute {  (data) in
            if let data = data {
                do {
                    let mealsListed: Meals? = try JSONDecoder().decode(Meals.self, from: data)
                    completionHandler(mealsListed, true)
                } catch {
                    print("error")
                    completionHandler(nil, false)
                }
                
            }
            else {
                completionHandler(nil, false)
            }
        }
    }
    
    static func fetchMealbyID(_ mealID: String, completionHandler: @escaping ([String: Any]?, Bool?) -> Void) {
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)")!
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
                let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                let task = session.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        completionHandler(nil, false)
                    } else if let data = data {
                        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        completionHandler(dataDictionary, true)
                    }
        }
        task.resume()
   }
}
