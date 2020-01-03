//
//  TemplatesCollectionViewCell.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/12/31.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit

class TemplatesCollectionViewCell: UICollectionViewCell {
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
//        let imgView: UIImageView = UIImageView()
//        imgView.image = UIImage.init(named: "bg_timetable_title")
//        imgView.isHidden = true
//        self.contentView.addSubview(imgView)
//        imgView.snp.makeConstraints { (make) in
//            make.edges.equalTo(self.contentView)
//        }
//        self.imgView = imgView
        
//        let titleLabel: UILabel = UILabel()
//        titleLabel.text = "Food Courts"
//        titleLabel.textColor = UIColor.green
//        titleLabel.font = UIFont.systemFont(ofSize: 10 * AutoSizeScaleX)
//        self.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(4*AutoSizeScaleX)
//            make.left.right.equalTo(self)
//            make.height.equalTo(20*AutoSizeScaleX)
//        }
//        let subtitleLabel: UILabel = UILabel()
//        subtitleLabel.text = "Always feeded you at its best quality"
//        subtitleLabel.textColor = UIColor.green
//        subtitleLabel.font = UIFont.systemFont(ofSize: 10 * AutoSizeScaleX)
//        self.addSubview(subtitleLabel)
//        subtitleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(titleLabel.snp.bottom).offset(2*AutoSizeScaleX)
//            make.left.right.equalTo(self)
//            make.height.equalTo(20*AutoSizeScaleX)
//        }
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
