//
//  CategoryController.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import UIKit

class CategoryController: UITableViewController {
    
    var courseViewModels = [CategoryViewModel]()
    let cellId = "cellId"
    
    let offlineImageArray: [UIImage] = [UIImage.init(named: "book-0")!,UIImage.init(named: "book-1")!,UIImage.init(named: "book-2")!,UIImage.init(named: "book-3")!,UIImage.init(named: "book-4")!]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        Service.shared.fetchCategories { (courses, err) in
            if let err = err {

                self.presentOfflineView()
                
                print("Failed to fetch courses:", err)
                return
            }
            
            self.courseViewModels = courses?.map({return CategoryViewModel(category: $0)}) ?? []
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CategoryCell
        let courseViewModel = courseViewModels[indexPath.row]
        cell.courseViewModel = courseViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseViewModel = courseViewModels[indexPath.row]
        print(courseViewModel.name)
        print(courseViewModel.list_name_encoded)
        print(courseViewModel.oldest_published_date)
        print(courseViewModel.newest_published_date)
        print(courseViewModel.updated)
        
        let bestSellersController = BestSellersController()
        bestSellersController.list_name_encoded = courseViewModel.list_name_encoded
        navigationController?.pushViewController(bestSellersController, animated: true)
    }
    
    fileprivate func setupTableView() {
        tableView.register(CategoryCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Categories"
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
    
    
    


    func presentOfflineView(){
        
        DispatchQueue.main.async {
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            imageView.animationImages = self.offlineImageArray
            imageView.animationDuration = 1.5
            imageView.animationRepeatCount = -1
            imageView.startAnimating()
            
            let offlineLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
            offlineLabel.text = "No internet connection detected..."
            offlineLabel.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            offlineLabel.textAlignment = .center
            offlineLabel.textColor = UIColor.white
            
            self.view.addSubview(imageView)
            self.view.addSubview(offlineLabel)
        }
}
}
class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 5, g: 88, b: 88)
    static let highlightColor = UIColor.rgb(r: 88, g: 188, b: 242)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}





