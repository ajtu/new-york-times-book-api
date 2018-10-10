//
//  BookInfoController.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import UIKit

class BookInfoController: UITableViewController {
    
    var book:BookViewModel?
    var rawBookDetails = [BookDetails]()
    var rawBookReviews = [BookReviews]()
    let cellId = "bookCellId"
    var list_name_encoded = ""
    var bookDetails: (title: String, author: String, description: String)? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        print(courseViewModels[indexPath.row])
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InfoCell
        let indexPath = indexPath.row
        if indexPath == 0 {
            cell.textLabel?.text = rawBookDetails[0].title
        }
        if indexPath == 1 {
            cell.textLabel?.text = rawBookDetails[0].author
        }
        if indexPath == 2 {
            cell.textLabel?.text = rawBookDetails[0].description
        }
        if indexPath == 3 {
            cell.textLabel?.text = "Amazon"
            cell.detailTextLabel?.text = book?.amazon_product_url
        }
        
        if indexPath == 4{
            cell.textLabel?.text = "NY Times"
            cell.detailTextLabel?.text = rawBookReviews[0].book_review_link
        }
        
        if indexPath == 5{
            cell.textLabel?.text = "Weeks On List"
            cell.detailTextLabel?.text = "\(book!.weeks_on_list)"
        }
        
        
        if indexPath == 6{
            cell.textLabel?.text = "Ranking"
            cell.detailTextLabel?.text = "\(book!.rank)"
        }
        
        
        
        
        if indexPath == 7{
            cell.textLabel?.text = "First Chapter"
            cell.detailTextLabel?.text = rawBookReviews[0].first_chapter_link
        }
        
        //        cell.courseViewModel = courseViewModel
        return cell
    }
    
    
    fileprivate func setupTableView() {
        tableView.register(InfoCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Info"
        navigationController?.navigationBar.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 199, b: 242)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        } else {
            // Fallback on earlier versions
        }
    }
    
}

