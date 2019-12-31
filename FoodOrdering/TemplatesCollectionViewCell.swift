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
    var weekLab: UILabel = UILabel()
    var dateLab: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.red
        
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        let imgView: UIImageView = UIImageView()
        imgView.image = UIImage.init(named: "bg_timetable_title")
        imgView.isHidden = true
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        self.imgView = imgView
        
        let dateTitleLab: UILabel = UILabel()
        dateTitleLab.text = "日期"
        dateTitleLab.textColor = UIColor.green
        dateTitleLab.font = UIFont.systemFont(ofSize: 10 * AutoSizeScaleX)
        imgView.addSubview(dateTitleLab)
        dateTitleLab.snp.makeConstraints { (make) in
            make.right.equalTo(imgView).offset(-4 * AutoSizeScaleX)
            make.top.equalTo(imgView).offset(6 * AutoSizeScaleX)
        }
        
        let timeTitleLab: UILabel = UILabel()
        timeTitleLab.text = "时间"
        timeTitleLab.textColor = UIColor.orange
        timeTitleLab.font = UIFont.systemFont(ofSize: 10 * AutoSizeScaleX)
        imgView.addSubview(timeTitleLab)
        timeTitleLab.snp.makeConstraints { (make) in
            make.left.equalTo(imgView).offset(4 * AutoSizeScaleX)
            make.bottom.equalTo(imgView).offset(-6 * AutoSizeScaleX)
        }
        
        let weekLab: UILabel = UILabel()
        weekLab.textColor = UIColor.brown
        weekLab.font = UIFont.systemFont(ofSize: 13 * AutoSizeScaleX)
        self.contentView.addSubview(weekLab)
        weekLab.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(5 * AutoSizeScaleX)
            make.centerX.equalTo(self.contentView)
        }
        self.weekLab = weekLab
        
        let dateLab: UILabel = UILabel()
        dateLab.isHidden = true
        dateLab.textColor = UIColor.brown
        dateLab.font = UIFont.systemFont(ofSize: 9 * AutoSizeScaleX)
        self.contentView.addSubview(dateLab)
        dateLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView).offset(-5 * AutoSizeScaleX)
            make.centerX.equalTo(self.contentView)
        }
        self.dateLab = dateLab
    }
}
