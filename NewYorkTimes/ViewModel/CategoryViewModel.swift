//
//  CategoryViewModel.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import Foundation

struct CategoryViewModel {
    
    let name: String
    let list_name_encoded: String
    let oldest_published_date: String
    let newest_published_date: String
    let updated: String
    
    // dependency inject (DI)
    init(category: Category) {
        self.name = category.list_name
        self.list_name_encoded = category.list_name_encoded
        self.oldest_published_date = category.oldest_published_date
        self.newest_published_date = category.newest_published_date
        self.updated = category.updated
        
    }
    
}
