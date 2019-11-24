//
//  RegisterViewController.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/11/21.
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

class RegisterViewController: UIViewController,UITextFieldDelegate {
    var configBGView = UIView()
    var configGetOTPBGView = UIView()
    
    var mobileNoTextField = SkyFloatingLabelTextField()
    var fullNameTextField = SkyFloatingLabelTextField()
    var passwordTextField = SkyFloatingLabelTextField()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configMainBGView()
        configSocialMainBGView()
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
        
        let mobileNoTextField = SkyFloatingLabelTextField()
        mobileNoTextField.placeholder = "Enter Mobile Number"
        mobileNoTextField.CustomTextField()
        mobileNoTextField.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        mobileNoTextField.borderStyle = UITextField.BorderStyle.none
        mobileNoTextField.autocorrectionType = UITextAutocorrectionType.no
        mobileNoTextField.keyboardType = UIKeyboardType.default
        mobileNoTextField.returnKeyType = UIReturnKeyType.done
        mobileNoTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        mobileNoTextField.textAlignment = .left
        mobileNoTextField.placeholderColor = UIColor.lightGray
        mobileNoTextField.delegate = self
        self.configBGView.addSubview(mobileNoTextField)
        self.mobileNoTextField = mobileNoTextField
        
        mobileNoTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(60*AutoSizeScaleX)
            make.left.equalTo(titleLabel)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let fullNameTextField = SkyFloatingLabelTextField()
        fullNameTextField.placeholder = "Full Name"
        fullNameTextField.CustomTextField()
        fullNameTextField.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        fullNameTextField.borderStyle = UITextField.BorderStyle.none
        fullNameTextField.autocorrectionType = UITextAutocorrectionType.no
        fullNameTextField.keyboardType = UIKeyboardType.default
        fullNameTextField.returnKeyType = UIReturnKeyType.done
        fullNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        fullNameTextField.textAlignment = .left
        fullNameTextField.placeholderColor = UIColor.lightGray
        fullNameTextField.delegate = self
        self.configBGView.addSubview(fullNameTextField)
        self.fullNameTextField = fullNameTextField
        
        fullNameTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(mobileNoTextField.snp_bottomMargin).offset(60*AutoSizeScaleX)
            make.left.equalTo(mobileNoTextField)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        
        let passwordTextField = SkyFloatingLabelTextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.CustomTextField()
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.textAlignment = .left
        passwordTextField.placeholderColor = UIColor.lightGray
        passwordTextField.delegate = self
        self.configBGView.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        passwordTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(fullNameTextField.snp_bottomMargin).offset(60*AutoSizeScaleX)
            make.left.equalTo(fullNameTextField)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        
    }
    func configSocialMainBGView(){
        let configGetOTPBGView = UIView()
        configGetOTPBGView.backgroundColor = UIColor.clear
        self.configBGView.addSubview(configGetOTPBGView)
        self.configGetOTPBGView = configGetOTPBGView
        configGetOTPBGView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(30*AutoSizeScaleX)
            make.left.right.equalTo(self.configBGView)
            make.bottom.equalTo(self.configBGView)
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
        self.configGetOTPBGView.addSubview(getOTPBtn)
        getOTPBtn.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(configGetOTPBGView).offset(20*AutoSizeScaleX)
            make.top.equalTo(configGetOTPBGView).offset(20*AutoSizeScaleX)
            make.width.equalTo(80*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
      
        
        let noteOTPLabel = UILabel()
        noteOTPLabel.text = "Note:-OTP will be sent to the above mentioned number."
        noteOTPLabel.textColor = .white
        noteOTPLabel.font = noteOTPLabel.font.withSize(13*AutoSizeScaleX)
        self.configGetOTPBGView.addSubview(noteOTPLabel)
        noteOTPLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(getOTPBtn.snp.bottom).offset(20*AutoSizeScaleX)
            make.left.equalTo(getOTPBtn.snp.left)
            make.right.equalTo(configGetOTPBGView.snp.right)
            make.height.equalTo(30*AutoSizeScaleX)
        }
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = "Already have an account?"
        dontHaveAccountLabel.textColor = .white
        dontHaveAccountLabel.font = dontHaveAccountLabel.font.withSize(18*AutoSizeScaleX)
        self.configGetOTPBGView.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(configGetOTPBGView.snp.bottom).offset(-40*AutoSizeScaleX)
            make.left.equalTo(noteOTPLabel.snp.left)
            make.width.equalTo(208*AutoSizeScaleX)
            make.height.equalTo(30*AutoSizeScaleX)
        }
        
        let signUpBtn = UIButton(type: .custom)
        signUpBtn.setTitle("Sign In", for: .normal)
        signUpBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        signUpBtn.setTitleColor(UIColor.green, for: .normal)
        signUpBtn.contentHorizontalAlignment = .left
        signUpBtn.clipsToBounds = true
        signUpBtn.addTarget(self, action:#selector(self.signInBtn), for: .touchUpInside)
        self.configGetOTPBGView.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(dontHaveAccountLabel)
            make.left.equalTo(dontHaveAccountLabel.snp.right)
            make.height.equalTo(32*AutoSizeScaleX)
            make.width.equalTo(130*AutoSizeScaleX)
        }
    }
    @objc func getOTPBtn(sender:UIButton!){
        if (mobileNoTextField.text?.isEmpty)! || (fullNameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
            showAlert(for: "Please fill the all details")

        }else{
            let mobileVerigyVC = MobileVerifyViewController()
            mobileVerigyVC.mobileNumberLabel.text = mobileNoTextField.text
            mobileVerigyVC.userNameLabel.text = fullNameTextField.text
            mobileVerigyVC.passwordTextField.text = passwordTextField.text
            self.present(mobileVerigyVC, animated: true, completion: nil)
        }
        
       
    }

    @objc func signInBtn(sender:UIButton!){
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
        
    }
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: alert, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
