//
//  BrandsCollectionViewCell.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2020/1/4.
//  Copyright © 2020 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    var imgView: UIImageView = UIImageView()
   

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = newWhiteSmokeColor
        
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {

        let imgView: UIImageView = UIImageView()
        imgView.image = UIImage.init(named: "samosas")
        imgView.isHidden = false
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            // make.edges.equalTo(self.contentView)
            make.top.equalTo(self).offset(2*AutoSizeScaleX)
            make.left.right.equalTo(self)
            make.bottom.equalTo(-40)
        }
        self.imgView = imgView
        
      
        
    }
}
