//
//  BestSellerController.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import UIKit

class BestSellersController: UITableViewController {
    
    var courseViewModels = [BookViewModel]()
    let cellId = "bookCellId"
    var list_name_encoded = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        fetchData()
        setupSegmentedControl()
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchCategoriesBestSeller(listName: list_name_encoded) { (courses, err) in
            if let err = err {
                self.alertOfflineAndNotCached()
                print("Failed to fetch Best Sellers:", err)
                return
            }
            
            self.courseViewModels = courses?.map({return BookViewModel(book: $0)}) ?? []
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(courseViewModels.count)
        return courseViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(courseViewModels[indexPath.row])
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BookCell
        let courseViewModel = courseViewModels[indexPath.row]
        cell.courseViewModel = courseViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let courseViewModel = courseViewModels[indexPath.row]
        print(courseViewModel)
        
        let bookInfoController = BookInfoController()
        bookInfoController.book = courseViewModel
        bookInfoController.rawBookDetails = courseViewModel.book_details
        bookInfoController.rawBookReviews = courseViewModel.reviews
            navigationController?.pushViewController(bookInfoController, animated: true)
             }
    
    
    fileprivate func setupTableView() {
        tableView.register(BookCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 100, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.setContentOffset(CGPoint(x: 0, y: 50), animated: false)
        tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Best Sellers"
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
    
    
    fileprivate func setupSegmentedControl(){
        let mySegmentedControl = UISegmentedControl (items: ["Rank","# of Weeks"])
        
        let xPostion:CGFloat = view.frame.size.width/2
        let yPostion:CGFloat = 0
        let elementWidth:CGFloat = view.frame.size.width/2
        let elementHeight:CGFloat = 30
        
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        
        // Make second segment selected
        mySegmentedControl.selectedSegmentIndex = 0
        
        //Change text color of UISegmentedControl
        mySegmentedControl.tintColor = UIColor.yellow
        
        //Change UISegmentedControl background colour
        mySegmentedControl.backgroundColor = UIColor.black
        
        // Add function to handle Value Changed events
        mySegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        self.view.addSubview(mySegmentedControl)
        
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        if(sender.selectedSegmentIndex == 0){
            courseViewModels.sort() { $0.rank < $1.rank } // sort the books by rank
            tableView.reloadData(); // notify the table view the data has changed
        }
        else{
            courseViewModels.sort() { $0.weeks_on_list > $1.weeks_on_list } // sort the books by # of weeks_on_list
            tableView.reloadData(); // notify the table view the data has changed
        }
    }
    
    func alertOfflineAndNotCached(){
        let alert = UIAlertController(title: "Data Not Saved", message: "Data is saved locally once connected to the Internet.\n\nPlease connect to Internet and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)

    }
    
    
}
