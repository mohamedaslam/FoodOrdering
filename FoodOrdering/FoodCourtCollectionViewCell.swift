//
//  FoodCourtCollectionViewCell.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2020/1/4.
//  Copyright © 2020 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit

class FoodCourtCollectionViewCell: UICollectionViewCell {
    var imgView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var subtitleLabel: UILabel = UILabel()
    var itemNameLabel: UILabel = UILabel()
    var statusInfoLabel: UILabel = UILabel()

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
        
        let itemNameLabel: UILabel = UILabel()
        itemNameLabel.text = "Square Mall "
        itemNameLabel.textColor = UIColor.black
        itemNameLabel.font = UIFont.systemFont(ofSize: 14 * AutoSizeScaleX)
        self.addSubview(itemNameLabel)
        itemNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp.bottom).offset(2*AutoSizeScaleX)
            make.left.right.equalTo(self)
            make.height.equalTo(16*AutoSizeScaleX)
        }
        
        let statusInfoLabel: UILabel = UILabel()
        statusInfoLabel.text = "Opening Soon"
        statusInfoLabel.textColor = UIColor.black
        statusInfoLabel.font = UIFont.systemFont(ofSize: 12 * AutoSizeScaleX)
        self.addSubview(statusInfoLabel)
        statusInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(itemNameLabel.snp.bottom).offset(2*AutoSizeScaleX)
            make.left.right.equalTo(self)
            make.height.equalTo(16*AutoSizeScaleX)
        }
        
    }
}
