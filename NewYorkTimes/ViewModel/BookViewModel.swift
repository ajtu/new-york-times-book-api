//
//  BookViewModel.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import Foundation
import UIKit

struct BookViewModel {
    
    let list_name:String
    let display_name:String
    let bestsellers_date: String
    let published_date:String
    let rank:Int
    let weeks_on_list:Int
    let rank_last_week:Int
    let amazon_product_url:String
    let book_details: [BookDetails]
    let reviews:[BookReviews]
    
    
    
    //    let detailTextString: String
    let accessoryType: UITableViewCell.AccessoryType
    
    // Dependency Injection (DI)
    init(book: Book) {
        self.list_name = book.list_name
        self.display_name = book.display_name
        self.bestsellers_date = book.bestsellers_date
        self.published_date = book.published_date
        self.rank = book.rank
        self.rank_last_week = book.rank_last_week
        self.amazon_product_url = book.amazon_product_url
        self.book_details = book.book_details
        self.reviews = book.reviews
        self.weeks_on_list = book.weeks_on_list
        
        
        if book.amazon_product_url == "" {
            accessoryType = .none
        } else {
            accessoryType = .detailDisclosureButton                }
    }
    
}
