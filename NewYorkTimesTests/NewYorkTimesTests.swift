//
//  NewYorkTimesTests.swift
//  NewYorkTimesTests
//
//  Created by Jo Tu on 10/6/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class NewYorkTimesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testBookViewModel() {
        
        let book = Book(list_name: "Fiction", display_name: "Hello", bestsellers_date: "", published_date: "", rank: 5, weeks_on_list: 5, rank_last_week: 5, amazon_product_url: "", book_details:[BookDetails](), reviews: [BookReviews]())
        let bookViewModel = BookViewModel(book: book)
        XCTAssertEqual(book.display_name, bookViewModel.display_name)
    }
    
    func testInfoDisclosureForAmazonLink() {
        
        let book1 = Book(list_name: "Non-fiction", display_name: "Hello", bestsellers_date: "", published_date: "", rank: 5, weeks_on_list: 5, rank_last_week: 5, amazon_product_url: "www.amazon.com", book_details:[BookDetails](), reviews: [BookReviews]())
        
        let book2 = Book(list_name: "Non-fiction", display_name: "Hello", bestsellers_date: "", published_date: "", rank: 5, weeks_on_list: 5, rank_last_week: 5, amazon_product_url: "", book_details:[BookDetails](), reviews: [BookReviews]())
        
        let bookViewModel1 = BookViewModel(book: book1)
        let bookViewModel2 = BookViewModel(book: book2)
        
        XCTAssertEqual(.detailDisclosureButton, bookViewModel1.accessoryType)
        XCTAssertEqual(.none, bookViewModel2.accessoryType)
    }
    

    

}
