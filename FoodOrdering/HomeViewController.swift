//
//  HomeViewController.swift
//  FoodOrdering
//
//  Created by Aslam on 2019/11/24.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var configBGView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let configBGView = UIView()
        configBGView.backgroundColor = UIColor.white
        self.view.addSubview(configBGView)
        self.configBGView = configBGView
        configBGView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.top.equalTo(self.view)
        }
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "MainScreen")
        self.configBGView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configBGView)
            make.left.equalTo(self.configBGView)
            make.right.equalTo(self.configBGView)
            make.bottom.equalTo(self.configBGView)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "HOME"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36.0*AutoSizeScaleX)
        configBGView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(configBGView).offset(70*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
                let loginBtn = UIButton(type: .custom)
                loginBtn.setTitle("BACK", for: .normal)
                loginBtn.backgroundColor = UIColor.lightGray
                loginBtn.layer.cornerRadius = 20
                loginBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
                loginBtn.setTitleColor(UIColor.white, for: .normal)
                loginBtn.contentHorizontalAlignment = .center
                loginBtn.clipsToBounds = true
                loginBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
                self.configBGView.addSubview(loginBtn)
                loginBtn.snp.makeConstraints{(make) -> Void in
                    make.centerX.centerY.equalTo(configBGView)
                    make.height.equalTo(40*AutoSizeScaleX)
                    make.width.equalTo(200*AutoSizeScaleX)
                }
        // Do any additional setup after loading the view.
    }
    @objc func loginBtn(sender:UIButton!){
    
          let loginVC = LoginViewController()
          self.present(loginVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
