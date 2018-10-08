//
//  Category.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import Foundation

struct QueryDescription : Decodable{
    let status:String
    let num_results:Int
    let results:[Category]
}
struct Category : Decodable{
    let list_name:String
    let display_name:String
    let list_name_encoded: String
    let oldest_published_date:String
    let newest_published_date:String
    let updated:String
}
