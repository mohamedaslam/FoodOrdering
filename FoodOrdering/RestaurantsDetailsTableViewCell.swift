//
//  RestaurantsDetailsTableViewCell.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2020/1/3.
//  Copyright © 2020 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit

class RestaurantsDetailsTableViewCell: UITableViewCell  {
    var iconImgView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    var categoryLabel: UILabel = UILabel()
    var openStatusLabel: UILabel = UILabel()
    var openingTimeLabel: UILabel = UILabel()
    var ratingLabel: UILabel = UILabel()
    var discountLabel: UILabel = UILabel()
    var codeLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        let configBGView = UIView()
        configBGView.backgroundColor = newWhiteSmokeColor
        configBGView.dropShadow = true
        self.addSubview(configBGView)
        configBGView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(12*AutoSizeScaleX)
            make.left.equalTo(self).offset(4*AutoSizeScaleX)
            make.right.equalTo(self).offset(-4*AutoSizeScaleX)
            make.bottom.equalTo(self.snp.bottom).offset(-6*AutoSizeScaleX)
        }

        let iconImgView: UIImageView = UIImageView()
        iconImgView.backgroundColor = .black
        iconImgView.layer.cornerRadius = 7 * AutoSizeScaleX
        iconImgView.clipsToBounds = true
        configBGView.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { (make) in
            make.top.equalTo(20*AutoSizeScaleX)
            make.left.equalTo(4*AutoSizeScaleX)
            make.width.equalTo(130*AutoSizeScaleX)
            make.height.equalTo(136*AutoSizeScaleX)
        }
        self.iconImgView = iconImgView
        
        //故事名称
        let titleLabel: UILabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = "Arabia Bun"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16*AutoSizeScaleX)
        configBGView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgView.snp.right).offset(6 * AutoSizeScaleX)
            make.width.equalTo(self)
            make.top.equalTo(iconImgView.snp.top).offset(5 * AutoSizeScaleX)
            make.height.equalTo(20*AutoSizeScaleX)
        }
        self.titleLabel = titleLabel
        
       let categoryLabel: UILabel = UILabel()
        categoryLabel.textColor = .black
        categoryLabel.text = "Veg & Non Veg"
        categoryLabel.font = UIFont.systemFont(ofSize: 14 * AutoSizeScaleX)
        configBGView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(self.contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(5 * AutoSizeScaleX)
            make.height.equalTo(20*AutoSizeScaleX)
        }
        self.categoryLabel = categoryLabel
        
        
       let openStatusLabel: UILabel = UILabel()
        openStatusLabel.textColor = .black
        openStatusLabel.text = "Timing:10:30 am - 23:30pm"

        openStatusLabel.font = UIFont.systemFont(ofSize: 14 * AutoSizeScaleX)
        configBGView.addSubview(openStatusLabel)
        openStatusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(self.contentView)
            make.top.equalTo(categoryLabel.snp.bottom).offset(5 * AutoSizeScaleX)
            make.height.equalTo(20*AutoSizeScaleX)
        }
        self.openStatusLabel = openStatusLabel
        
        let openingTimeLabel: UILabel = UILabel()
        openingTimeLabel.textColor = .black
        openingTimeLabel.text = "Open Now Closes in 03:00hrs"

        openingTimeLabel.font = UIFont.systemFont(ofSize: 14 * AutoSizeScaleX)
        configBGView.addSubview(openingTimeLabel)
        openingTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(self.contentView)
            make.top.equalTo(openStatusLabel.snp.bottom).offset(5 * AutoSizeScaleX)
            make.height.equalTo(20*AutoSizeScaleX)
        }
        self.openingTimeLabel = openingTimeLabel
        
        let ratingLabel: UILabel = UILabel()
        ratingLabel.textColor = .black
        ratingLabel.text = "3.8(665 people)"

        ratingLabel.font = UIFont.systemFont(ofSize: 14 * AutoSizeScaleX)
        configBGView.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(self.contentView)
            make.top.equalTo(openingTimeLabel.snp.bottom).offset(5 * AutoSizeScaleX)
            make.height.equalTo(20*AutoSizeScaleX)
        }
        self.ratingLabel = ratingLabel
        
        let configBottonCellBGView = UIView()
        configBottonCellBGView.backgroundColor = UIColor.white
        configBottonCellBGView.dropShadow = true
        configBGView.addSubview(configBottonCellBGView)
        configBottonCellBGView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(configBGView)
            make.height.equalTo(24*AutoSizeScaleX)
        }
        
        let discountLabel: UILabel = UILabel()
        discountLabel.textColor = .black
        discountLabel.text = "50% off upto Rs 250"
        discountLabel.font = UIFont.systemFont(ofSize: 14 * AutoSizeScaleX)
        configBottonCellBGView.addSubview(discountLabel)
        discountLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(configBottonCellBGView)
            make.width.equalTo(SCREEN_WIDTH/2*AutoSizeScaleX)
            make.height.equalTo(20*AutoSizeScaleX)
        }
        self.discountLabel = discountLabel
        
        let codeLabel: UILabel = UILabel()
        codeLabel.textColor = .black
        codeLabel.text = "Code QEXCN0034"
        codeLabel.textAlignment = .right
        codeLabel.font = UIFont.systemFont(ofSize: 14 * AutoSizeScaleX)
        configBottonCellBGView.addSubview(codeLabel)
        codeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(configBottonCellBGView)
            make.top.height.width.equalTo(discountLabel)
        }
        self.codeLabel = codeLabel
        
       
    }
}
extension UIView {
    @IBInspectable var dropShadow: Bool {
        set{
            if newValue {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.4
                layer.shadowRadius = 1
                layer.shadowOffset = CGSize.zero
            } else {
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowOffset = CGSize.zero
            }
        }
        get {
            return layer.shadowOpacity > 0
        }
    }
}
