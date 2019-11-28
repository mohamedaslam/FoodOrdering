//
//  ChangePwdViewController.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/11/28.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import SkyFloatingLabelTextField
import MBProgressHUD
import SystemConfiguration
import SnapKit

class ChangePwdViewController: UIViewController,UITextFieldDelegate {
    var configBGView = UIView()
    var passwordTextField = SkyFloatingLabelTextField()
    var repasswordTextField = SkyFloatingLabelTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        configMainBGView()
        // Do any additional setup after loading the view.
    }
    
    func configMainBGView(){
        let configBGView = UIView()
        configBGView.backgroundColor = UIColor.white
        self.view.addSubview(configBGView)
        self.configBGView = configBGView
        configBGView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.top.equalTo(self.view)
        }
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "LoginBackground")
        self.configBGView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configBGView)
            make.left.equalTo(self.configBGView)
            make.right.equalTo(self.configBGView)
            make.bottom.equalTo(self.configBGView)
        }
        let titleLabel = UILabel()
        titleLabel.text = "Quisiera"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36.0*AutoSizeScaleX)
        configBGView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(configBGView).offset(70*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
        let passwordTextField = SkyFloatingLabelTextField()
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.CustomTextField()
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.numberPad
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.textAlignment = .left
        passwordTextField.placeholderColor = UIColor.lightGray
        passwordTextField.delegate = self
        self.configBGView.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        passwordTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(60*AutoSizeScaleX)
            make.left.equalTo(titleLabel)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let repasswordTextField = SkyFloatingLabelTextField()
        repasswordTextField.placeholder = "Re Enter Password"
        repasswordTextField.CustomTextField()
        repasswordTextField.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        repasswordTextField.borderStyle = UITextField.BorderStyle.none
        repasswordTextField.autocorrectionType = UITextAutocorrectionType.no
        repasswordTextField.keyboardType = UIKeyboardType.default
        repasswordTextField.returnKeyType = UIReturnKeyType.done
        repasswordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        repasswordTextField.textAlignment = .left
        repasswordTextField.placeholderColor = UIColor.lightGray
        repasswordTextField.delegate = self
        self.configBGView.addSubview(repasswordTextField)
        self.repasswordTextField = repasswordTextField
        
        repasswordTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40*AutoSizeScaleX)
            make.left.equalTo(passwordTextField)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let createPwdBtn = UIButton(type: .custom)
        createPwdBtn.setTitle("Create Password", for: .normal)
        createPwdBtn.titleLabel?.font = .systemFont(ofSize:16*AutoSizeScaleX)
        createPwdBtn.setTitleColor(whiteSmokeColor, for: .normal)
        createPwdBtn.backgroundColor = UIColor.black
        createPwdBtn.contentHorizontalAlignment = .center
        createPwdBtn.clipsToBounds = true
        createPwdBtn.addTarget(self, action:#selector(self.createPwdButton), for: .touchUpInside)
        self.configBGView.addSubview(createPwdBtn)
        createPwdBtn.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(passwordTextField)
            make.top.equalTo(repasswordTextField.snp.bottom).offset(60*AutoSizeScaleX)
            make.width.equalTo(200*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        
        let willCreateLaterBtn = UIButton(type: .custom)
        willCreateLaterBtn.setTitle("Will Create Later", for: .normal)
        willCreateLaterBtn.titleLabel?.font = .systemFont(ofSize:16*AutoSizeScaleX)
        willCreateLaterBtn.setTitleColor(.white, for: .normal)
        willCreateLaterBtn.backgroundColor = UIColor.clear
        willCreateLaterBtn.contentHorizontalAlignment = .center
        willCreateLaterBtn.clipsToBounds = true
        willCreateLaterBtn.addTarget(self, action:#selector(self.willcreateLaterBtn), for: .touchUpInside)
        self.configBGView.addSubview(willCreateLaterBtn)
        willCreateLaterBtn.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(passwordTextField)
            make.top.equalTo(createPwdBtn.snp.bottom).offset(10*AutoSizeScaleX)
            make.width.height.equalTo(createPwdBtn)
        }
     
        
    }
    @objc func createPwdButton(sender:UIButton!){
       //   self.configVerifyBGView.isHidden = false
        //   self.configGetBGView.isHidden = true
       }
    @objc func willcreateLaterBtn(sender:UIButton!){
        let homeVC = HomeViewController()
        self.present(homeVC, animated: true, completion: nil)
    }
}
