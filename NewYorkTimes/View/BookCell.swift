//
//  BookCell.swift
//  NewYorkTimes
//
//  Created by Jo Tu on 10/8/18.
//  Copyright © 2018 alvorithms. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    var courseViewModel: BookViewModel! {
        didSet {
            
            textLabel?.text = courseViewModel.book_details[0].title
            detailTextLabel?.text = courseViewModel.book_details[0].author
            
            accessoryType = courseViewModel.accessoryType
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = isHighlighted ? .highlightColor : .white
        textLabel?.textColor = isHighlighted ? UIColor.white : .mainTextBlue
        detailTextLabel?.textColor = isHighlighted ? .white : .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // cell customization
        textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        textLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
