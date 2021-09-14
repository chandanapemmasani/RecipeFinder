//
//  NetworkRequest.swift
//  RecipeFinder
//
//  Created by Chandana Pemmasani on 9/13/21.
//

import Foundation

class NetworkRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func execute(withCompletion completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data: Data?, _, _) -> Void in
            DispatchQueue.main.async {
                completion(data)
            }
        })
        task.resume()
    }
}
