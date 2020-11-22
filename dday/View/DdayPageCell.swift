//
//  DdayPageCell.swift
//  dday
//
//  Created by jinhyuk on 2020/11/23.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import UIKit

class DdayPageCell: UICollectionViewCell {

    let tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }

}
