//
//  CategoryTableViewCell.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2020/1/6.
//  Copyright © 2020 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           self.contentView.backgroundColor = .white
           
           configView()
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    func configView(){
             /////////
             let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
                               //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
            let headerView = UICollectionView(frame: CGRect(x: 4, y: 40, width: SCREEN_WIDTH, height: 200), collectionViewLayout: layout)
            headerView.backgroundColor = .red
            headerView.isPagingEnabled = true
            headerView.isUserInteractionEnabled = true
            headerView.dataSource = self
            headerView.delegate = self
            headerView.showsHorizontalScrollIndicator = false
            self.addSubview(headerView)
            headerView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }

}
extension CategoryTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        return cell
    }
    // MARK: UICollectionViewDataSource
       func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }

       // MARK: UICollectionViewDelegateFlowLayout
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
           return CGSize(width: 100, height: 100)
       }
  
}

extension CategoryTableViewCell : UICollectionViewDelegateFlowLayout {
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
}
