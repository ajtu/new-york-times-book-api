//
//  Service.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    let defaults = UserDefaults.standard

    
    func fetchCategories(completion: @escaping ([Category]?, Error?) -> ()) {
        let apiKey = "ef3a882bbbf74ee0b88ccd539ec81f8a"
        var jsonURLString = "https://api.nytimes.com/svc/books/v3/lists/names.json";
        jsonURLString += "?q=&"
        jsonURLString += "api-key=\(apiKey)"
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                
                let retrieved = self.defaults.string(forKey: jsonURLString)
                let retrievedData = retrieved?.data(using: .utf8)
                print(retrievedData)
                do {
                    let queryInfo = try JSONDecoder().decode(QueryDescription.self, from: retrievedData ?? NSData() as Data)
                    DispatchQueue.main.async {
                        completion(queryInfo.results, nil)
                        print(queryInfo.results)
                    }
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
                
                if retrieved == nil{
                    completion(nil, err)
                    print("Failed to fetch courses:", err)
                    return
                }
            }
            
            // check response

            
            guard let data = data else { return }
            
            //set defaults
            let jsonString  = String(data: data, encoding: .utf8)
            self.defaults.set(jsonString, forKey: jsonURLString)
            
            
            do {
                let queryInfo = try JSONDecoder().decode(QueryDescription.self, from: data)
                DispatchQueue.main.async {
                    completion(queryInfo.results, nil)
                                        print(queryInfo.results)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }

//            do {
//                let queryInfo = try JSONDecoder().decode(QueryDescription.self, from: data)
//                DispatchQueue.main.async {
//                    completion(queryInfo.results, nil)
////                    print(queryInfo.results)
//                }
//            } catch let jsonErr {
//                print("Failed to decode:", jsonErr)
//            }
            }.resume()
    }
    
    
    func fetchCategoriesBestSeller(listName: String, completion: @escaping ([Book]?, Error?) -> ()) {
        let apiKey = "ef3a882bbbf74ee0b88ccd539ec81f8a"
        var jsonURLString = "https://api.nytimes.com/svc/books/v3/lists";
        jsonURLString += "?list="
        jsonURLString += listName
        jsonURLString += "&"
        jsonURLString += "api-key=\(apiKey)"
        print(jsonURLString)
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                
                let retrieved = self.defaults.string(forKey: jsonURLString)
                let retrievedData = retrieved?.data(using: .utf8)
                print(retrievedData)
                do {
                    let queryInfo = try JSONDecoder().decode(BookQueryDescription.self, from: retrievedData ?? NSData() as Data)
                    DispatchQueue.main.async {
                        completion(queryInfo.results, nil)
                        print(queryInfo.results)
                    }
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
                
                if retrieved == nil{
                    completion(nil, err)
                    print("Failed to fetch courses:", err)
                    return
                }
            }
            
            // check response
            
            
            
            guard let data = data else { return }
            
            let jsonString  = String(data: data, encoding: .utf8)
            self.defaults.set(jsonString, forKey: jsonURLString)

            
            do {
                
                let jsonString  = String(data: data, encoding: .utf8)
                print(jsonString)
                
                
                let queryInfo = try JSONDecoder().decode(BookQueryDescription.self, from: data)
                DispatchQueue.main.async {
                    print(queryInfo)
                    print(queryInfo.results)
                    print(queryInfo.results.count)
                    completion(queryInfo.results, nil)
                }
            } catch let jsonErr {
                print("Failed to decode:", jsonErr)
            }
            }.resume()
    }
    
}
