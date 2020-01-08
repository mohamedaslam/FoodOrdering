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
        let titleLabel: UILabel = UILabel()
                                 titleLabel.text = "Cuisines For You"
                                 titleLabel.textColor = UIColor.black
                                 titleLabel.font = UIFont.systemFont(ofSize: 20 * AutoSizeScaleX)
                                 self.addSubview(titleLabel)
                                 titleLabel.snp.makeConstraints { (make) in
                                     make.top.equalTo(self.snp.top).offset(8*AutoSizeScaleX)
                                     make.left.right.equalTo(self)
                                     make.height.equalTo(16*AutoSizeScaleX)
                                 }
                                let subtitleLabel: UILabel = UILabel()
                                subtitleLabel.text = "Most preffered meals in your location"
                                subtitleLabel.textColor = UIColor.darkGray
                                subtitleLabel.font = UIFont.systemFont(ofSize: 12 * AutoSizeScaleX)
                                self.addSubview(subtitleLabel)
                                subtitleLabel.snp.makeConstraints { (make) in
                                    make.top.equalTo(titleLabel.snp.bottom).offset(4*AutoSizeScaleX)
                                    make.left.right.equalTo(self)
                                    make.height.equalTo(16*AutoSizeScaleX)
                                }
                                let moreBtn: UIButton = UIButton(type: .custom)
                               // moreBtn.tag = section
                                moreBtn.setTitle("See all", for: .normal)
                                moreBtn.setTitleColor(.red, for: .normal)
                               // moreBtn.setImage(UIImage(named: "general_arrow_orange"), for: .normal)
                                moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                                moreBtn.addTarget(self, action: #selector(moreBtnAction(sender:)), for: .touchUpInside)
                                self.addSubview(moreBtn)
                                moreBtn.snp.makeConstraints { (make) in
                                    make.right.equalTo(self)
                                   make.top.equalTo(6*AutoSizeScaleX)
                                   make.height.equalTo(20*AutoSizeScaleX)
                                    make.width.equalTo(60 * AutoSizeScaleX)
                                }
             /////////
             let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
                               //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
            let headerView = UICollectionView(frame: CGRect(x: 4, y: 44, width: SCREEN_WIDTH, height: 200), collectionViewLayout: layout)
            headerView.backgroundColor = .white
            headerView.isPagingEnabled = true
            headerView.isUserInteractionEnabled = true
            headerView.dataSource = self
            headerView.delegate = self
            headerView.showsHorizontalScrollIndicator = false
            self.addSubview(headerView)
            headerView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    @objc func moreBtnAction(sender: UIButton) {
        
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
          
           return CGSize(width: 130, height: 150)
       }
  
}

extension CategoryTableViewCell : UICollectionViewDelegateFlowLayout {
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
}
