//
//  Book.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import Foundation

struct BookQueryDescription : Decodable{
    let status:String
    let num_results:Int
    let results:[Book]
    let last_modified: String
}

struct Book : Decodable{
    let list_name:String
    let display_name:String
    let bestsellers_date: String
    let published_date:String
    let rank:Int
    let weeks_on_list: Int
    let rank_last_week:Int
    let amazon_product_url:String
    let book_details: [BookDetails]
    let reviews: [BookReviews]
}

struct BookDetails: Decodable{
    let title: String
    let author: String
    let description: String
}


struct BookReviews: Decodable{
    let book_review_link: String?
    let first_chapter_link: String?
    let sunday_review_link: String?
    let article_chapter_link: String?
}
