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
    var pageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        
        // test
//        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        collectionViewLayout.minimumInteritemSpacing = 10
//        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func JHCustomTabBar(select index: Int) {
//        self.customTabBar.constraintLeading?.layoutConstraints.first?.constant = CGFloat(Int(self.view.frame.width) / 2 * index)
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
//            self.view.layoutIfNeeded()
//        } completion: { (finish) in
//            print(finish)
//            JHLog(index)
            let indexPath = IndexPath(row: index, section: 0)
            self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
      return true
    }
    
    override func loadView() {
        super.loadView()
    
        self.setCustomTabBar()
        self.setNavigationBar()
        self.setupPageCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testArray = ["디데이", "더보기"]
        customTabBar.setTextList(array: testArray)
        customTabBar.constrainttWidth?.layoutConstraints.first?.constant = self.view.frame.size.width / CGFloat(customTabBar.textArray.count)
        
    }
    
    func setupPageCollectionView(){
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.backgroundColor = .clear
        pageCollectionView.showsHorizontalScrollIndicator = false
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.register(UINib(nibName: PageCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: PageCell.reusableIdentifier)
        self.view.addSubview(pageCollectionView)
        pageCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        pageCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        pageCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        pageCollectionView.topAnchor.constraint(equalTo: self.customTabBar.bottomAnchor, constant: 10).isActive = true
        
    }
    
    func setCustomTabBar() {
        self.view.addSubview(customTabBar)
        customTabBar.backgroundColor = .lightGray
        customTabBar.delegate = self
        customTabBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            
            // 하단에 위치시키고 싱픈 경우
            // make.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    func setNavigationBar() {
//        self.navigationController?.hidesBarsOnSwipe = true
        
        // 기본 네비게이션뷰 밑줄 삭제
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // 네비게이션바는 기본적으로 반투명이기에 False 설정
        // self.navigationController?.navigationBar.isTranslucent = false
        
        self.title = "메인화면"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let navItem = UINavigationItem(title: "SomeTitle")
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        
        navItem.rightBarButtonItems?.append(doneItem)
        navItem.rightBarButtonItems?.append(doneItem2)
        
        self.navigationItem.rightBarButtonItems = [doneItem, doneItem2]
    }
    
}

extension DdayTableViewCotrollerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.reusableIdentifier, for: indexPath) as! PageCell
        cell.label.text = "\(indexPath.row + 1)번째 뷰"
        
        // 셀 테두리
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 4
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x)
        
        // 30이 나온 이유: 전체 크기 - 인셋
        var itemAt = Int(targetContentOffset.pointee.x / (self.view.frame.width - 30))
        if itemAt < 0 {
            itemAt = 0
        }
        
        let indexPath = IndexPath(item: itemAt, section: 0)
        self.customTabBar.customCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
}

extension DdayTableViewCotrollerViewController: UICollectionViewDelegateFlowLayout {
//    // 셀사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageCollectionView.frame.width - 20, height: pageCollectionView.frame.height - 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
