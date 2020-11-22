//
//  CustomCollectionViewCell.swift
//  dday
//
//  Created by jinhyuk on 2020/11/02.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {

    var constrainttWidth: Constraint?
    var constraintLeading: Constraint?
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Tab"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var selectPositionView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.isHidden = true
        return view
    }()
    
    override var isSelected: Bool {
        didSet{
            print("Changed")
            self.label.textColor = isSelected ? .black : .lightGray
            self.label.font = UIFont.systemFont(ofSize: isSelected ? 20 : 16)
            self.selectPositionView.isHidden = isSelected ? false : true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(selectPositionView)
        selectPositionView.snp.makeConstraints { (make) in
            // [TODO] 외부 주입
            self.constrainttWidth = make.width.equalTo(label.snp.width).constraint
            make.height.equalTo(5)
            self.constraintLeading = make.leading.equalTo(label.snp.leading).constraint
            make.bottom.equalToSuperview()
        }
    }
}
