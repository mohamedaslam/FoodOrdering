//
//  ForgotPwdViewController.swift
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


class ForgotPwdViewController: UIViewController {
    var configBGView = UIView()
    var configGetBGView = UIView()
    var configVerifyBGView = UIView()
    var txtOTPView: DPOTPView!
    var mobileNoTextField = SkyFloatingLabelTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        configMainBGView()
        
        self.configVerifyBGView.isHidden = true
        self.configGetBGView.isHidden = false
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
        ConfigGetOTPBGmethod()
        configVerifyOTPBGmethod()
        configCreateAccountBGView()
       }
    func configVerifyOTPBGmethod(){
        let configVerifyBGView = UIView()
        configVerifyBGView.backgroundColor = UIColor.clear
        self.configBGView.addSubview(configVerifyBGView)
        self.configVerifyBGView = configVerifyBGView
        configVerifyBGView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(130*AutoSizeScaleX)
                make.left.right.equalTo(self.configBGView)
                make.height.equalTo(250*AutoSizeScaleX)
        }
        
        txtOTPView = DPOTPView()
        txtOTPView.count = 4
        txtOTPView.spacing = 10
        txtOTPView.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(25.0))!
        txtOTPView.dpOTPViewDelegate = self
        txtOTPView.dismissOnLastEntry = true
        txtOTPView.borderColorTextField = .black
        txtOTPView.selectedBorderColorTextField = .blue
        txtOTPView.borderWidthTextField = 2
        txtOTPView.backGroundColorTextField = .lightGray
        txtOTPView.cornerRadiusTextField = 8
        txtOTPView.isCursorHidden = true
        //        txtOTPView.isSecureTextEntry = true
        //        txtOTPView.isBottomLineTextField = true
        //        txtOTPView.isCircleTextField = true
        self.configVerifyBGView.addSubview(txtOTPView)
        txtOTPView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configVerifyBGView).offset(40*AutoSizeScaleX)
            make.left.right.equalTo(self.configBGView)
            make.height.equalTo(100*AutoSizeScaleX)
            }
        
    }
    func ConfigGetOTPBGmethod(){
        let configGetBGView = UIView()
        configGetBGView.backgroundColor = UIColor.clear
        self.configBGView.addSubview(configGetBGView)
        self.configGetBGView = configGetBGView
        configGetBGView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(130*AutoSizeScaleX)
                make.left.right.equalTo(self.configBGView)
                make.height.equalTo(250*AutoSizeScaleX)
        }
        
        
        let getOTPBtn = UIButton(type: .custom)
              // facebookBtn.setBackgroundImage(UIImage(named: "facebookImg"), for: .normal)
              getOTPBtn.setTitle("Get OTP", for: .normal)
              getOTPBtn.titleLabel?.font = .systemFont(ofSize:16*AutoSizeScaleX)
              getOTPBtn.setTitleColor(whiteSmokeColor, for: .normal)
              getOTPBtn.backgroundColor = UIColor.black
              getOTPBtn.contentHorizontalAlignment = .center
              getOTPBtn.clipsToBounds = true
              getOTPBtn.addTarget(self, action:#selector(self.getOTPBtn), for: .touchUpInside)
              self.configGetBGView.addSubview(getOTPBtn)
              getOTPBtn.snp.makeConstraints{(make) -> Void in
                  make.left.equalTo(configGetBGView).offset(20*AutoSizeScaleX)
                  make.top.equalTo(configGetBGView).offset(50*AutoSizeScaleX)
                  make.width.equalTo(80*AutoSizeScaleX)
                  make.height.equalTo(40*AutoSizeScaleX)
              }
              
            
              
              let noteOTPLabel = UILabel()
              noteOTPLabel.text = "Note:-OTP will be sent to the above mentioned number."
              noteOTPLabel.textColor = .white
              noteOTPLabel.font = noteOTPLabel.font.withSize(13*AutoSizeScaleX)
              self.configGetBGView.addSubview(noteOTPLabel)
              noteOTPLabel.snp.makeConstraints{(make) -> Void in
                  make.top.equalTo(getOTPBtn.snp.bottom).offset(20*AutoSizeScaleX)
                  make.left.equalTo(getOTPBtn.snp.left)
                  make.right.equalTo(configGetBGView.snp.right)
                  make.height.equalTo(30*AutoSizeScaleX)
              }
             
              
    }
     @objc func getOTPBtn(sender:UIButton!){
           self.configVerifyBGView.isHidden = false
            self.configGetBGView.isHidden = true
        }
    func configCreateAccountBGView(){
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = "I dont have an account?"
        dontHaveAccountLabel.textColor = .white
        dontHaveAccountLabel.font = dontHaveAccountLabel.font.withSize(18*AutoSizeScaleX)
        self.configBGView.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(self.configBGView.snp.bottom).offset(-180*AutoSizeScaleX)
            make.left.equalTo(self.configBGView).offset(20*AutoSizeScaleX)
            make.width.equalTo(200*AutoSizeScaleX)
            make.height.equalTo(30*AutoSizeScaleX)
        }
        
        let signUpBtn = UIButton(type: .custom)
        signUpBtn.setTitle("Create Account", for: .normal)
        signUpBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        signUpBtn.setTitleColor(UIColor.green, for: .normal)
        signUpBtn.contentHorizontalAlignment = .left
        signUpBtn.clipsToBounds = true
        signUpBtn.addTarget(self, action:#selector(self.createAccountBtn), for: .touchUpInside)
        self.configBGView.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(dontHaveAccountLabel)
            make.left.equalTo(dontHaveAccountLabel.snp_rightMargin)
            make.height.equalTo(32*AutoSizeScaleX)
            make.width.equalTo(130*AutoSizeScaleX)
        }
        let byCountiuingLabel = UILabel()
        byCountiuingLabel.text = "By Continuing, you agree to the"
        byCountiuingLabel.textColor = .white
        byCountiuingLabel.font = dontHaveAccountLabel.font.withSize(11*AutoSizeScaleX)
        self.configBGView.addSubview(byCountiuingLabel)
        byCountiuingLabel.snp.makeConstraints{(make) -> Void in
        make.bottom.equalTo(self.configBGView.snp.bottom).offset(-40*AutoSizeScaleX)
        make.left.equalTo(self.configBGView).offset(10*AutoSizeScaleX)
            make.width.equalTo(180*AutoSizeScaleX)
            make.height.equalTo(30*AutoSizeScaleX)
        }
               
        let termsofUse = UIButton(type: .custom)
        termsofUse.setTitle("Terms of Use and Privacy Policy", for: .normal)
        termsofUse.titleLabel?.font = .systemFont(ofSize:11*AutoSizeScaleX)
        termsofUse.setTitleColor(UIColor.green, for: .normal)
        termsofUse.contentHorizontalAlignment = .left
        termsofUse.clipsToBounds = true
        termsofUse.addTarget(self, action:#selector(self.createAccountBtn), for: .touchUpInside)
        self.configBGView.addSubview(termsofUse)
        termsofUse.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(byCountiuingLabel)
            make.left.equalTo(byCountiuingLabel.snp_rightMargin)
            make.height.equalTo(32*AutoSizeScaleX)
            make.width.equalTo(180*AutoSizeScaleX)
        }
       
    }
    @objc func createAccountBtn(sender:UIButton!){
          let registerVC = RegisterViewController()
          self.present(registerVC, animated: true, completion: nil)

      }
}
extension ForgotPwdViewController : DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
        if(position == 4){
            let changePwdVC = ChangePwdViewController()
             self.present(changePwdVC, animated: true, completion: nil)
        }
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
}
