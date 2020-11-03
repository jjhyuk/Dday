//
//  CustomTabBar.swift
//  dday
//
//  Created by jinhyuk on 2020/11/02.
//  Copyright © 2020 jinhyuk. All rights reserved.
//

import UIKit
import SnapKit

protocol JHCustomTabBarDelegate: class {
    func JHCustomTabBar(select index:Int)
}

class JHCustomTabBar: UIView {
    
    var delegate: JHCustomTabBarDelegate?
    
    var constrainttWidth: Constraint?
    var constraintLeading: Constraint?
    
    //
    var textArray: Array<String> = ["Tab!"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpCustomTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var customCollectionView: UICollectionView = {
        var collectViewLayout = UICollectionViewFlowLayout()
        collectViewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    var selectPositionView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    func setTextList(array: Array<String>) -> Self {
        
        textArray = array
        customCollectionView.reloadData()
        
        let indexPath = IndexPath(item: 0, section: 0)
        customCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        
        return self
    }
    
    func setUpCustomTabBar() {
        
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        customCollectionView.showsHorizontalScrollIndicator = false
        customCollectionView.showsVerticalScrollIndicator = false
        customCollectionView.isScrollEnabled = false
        
        // [TODO] 차후 이름 외부에서 받도록 변경
        customCollectionView.register(UINib(nibName: CustomCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.reusableIdentifier)
        
        let indexPath = IndexPath(item: 0, section: 0)
        customCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        
        self.addSubview(customCollectionView)
        customCollectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
        }
        
        
        self.addSubview(selectPositionView)
        selectPositionView.snp.makeConstraints { (make) in
            // [TODO] 외부 주입
            self.constrainttWidth = make.width.equalTo(self.frame.size.width / CGFloat(textArray.count)).constraint
            make.height.equalTo(5)
            self.constraintLeading = make.leading.equalToSuperview().constraint
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}

extension JHCustomTabBar: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        self.delegate?.JHCustomTabBar(select: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as?CustomCollectionViewCell else {
            return
        }
        
        cell.label.textColor = .lightGray
    }
    
}

extension JHCustomTabBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        textArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 커스텀 탭바 갯수
        // [TODO] 차후 변경 가능하도록 수정
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.reusableIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.label.text = textArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // [TODO] 외부에서 주입하도록 수정
        return CGSize(width: self.frame.width / CGFloat(textArray.count) , height: 55)
    }
}

extension JHCustomTabBar: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
