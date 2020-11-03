//
//  DdayTableViewCotrollerViewController.swift
//  dday
//
//  Created by jinhyuk on 2020/11/02.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import UIKit
import SnapKit

class DdayTableViewCotrollerViewController: UIViewController, JHCustomTabBarDelegate {
    
    var customTabBar:JHCustomTabBar = dday.JHCustomTabBar()
    
    func JHCustomTabBar(select index: Int) {
        
        self.customTabBar.constraintLeading?.layoutConstraints.first?.constant = CGFloat(Int(self.view.frame.width) / 2 * index)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        } completion: { (finish) in
            print(finish)
            JHLog(index)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(customTabBar)
        
        customTabBar.delegate = self
        
        customTabBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            
            // 하단에 위치시키고 싱픈 경우
//            make.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testArray = ["디데이", "더보기"]
        customTabBar.setTextList(array: testArray)
        
        customTabBar.constrainttWidth?.layoutConstraints.first?.constant = self.view.frame.size.width / CGFloat(customTabBar.textArray.count)
        
    }
    


}
