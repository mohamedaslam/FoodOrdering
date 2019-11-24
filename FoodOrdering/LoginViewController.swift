//
//  LoginViewController.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/11/21.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import SkyFloatingLabelTextField
import MBProgressHUD
import SystemConfiguration
import SnapKit



class LoginViewController: UIViewController,UITextFieldDelegate {
    var configBGView = UIView()
    var configSocialView = UIView()

    var mobileNoTextField = SkyFloatingLabelTextField()
    var passwordTextField = SkyFloatingLabelTextField()
    var loginnBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        configMainBGView()
        configSocialMainBGView()
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
        mobileNoTextField.placeholderColor = UIColor.white
        mobileNoTextField.delegate = self
        self.configBGView.addSubview(mobileNoTextField)
        self.mobileNoTextField = mobileNoTextField
        
        mobileNoTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(60*AutoSizeScaleX)
            make.left.equalTo(titleLabel)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let passwordTextField = SkyFloatingLabelTextField()
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.CustomTextField()
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.textAlignment = .left
        passwordTextField.placeholderColor = UIColor.white
        passwordTextField.delegate = self
        self.configBGView.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        passwordTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(mobileNoTextField.snp.bottom).offset(30*AutoSizeScaleX)
            make.left.equalTo(mobileNoTextField)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let forgotPwdBtn = UIButton(type: .custom)
        forgotPwdBtn.setTitle("Forgot Password?", for: .normal)
        forgotPwdBtn.layer.cornerRadius = 20
        forgotPwdBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        forgotPwdBtn.setTitleColor(UIColor.orange, for: .normal)
        forgotPwdBtn.contentHorizontalAlignment = .left
        forgotPwdBtn.clipsToBounds = true
        forgotPwdBtn.addTarget(self, action:#selector(self.forgotPwdBtn), for: .touchUpInside)
        self.configBGView.addSubview(forgotPwdBtn)
        forgotPwdBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16*AutoSizeScaleX)
            make.left.equalTo(passwordTextField)
            make.height.equalTo(40*AutoSizeScaleX)
            make.width.equalTo(150*AutoSizeScaleX)
        }
        
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Sign In", for: .normal)
        loginBtn.backgroundColor = UIColor.black
//        loginBtn.layer.cornerRadius = 20
        loginBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.contentHorizontalAlignment = .center
        loginBtn.clipsToBounds = true
        loginBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
        self.configBGView.addSubview(loginBtn)
        self.loginnBtn = loginBtn
        loginBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(forgotPwdBtn.snp.bottom).offset(30*AutoSizeScaleX)
            make.left.equalTo(forgotPwdBtn)
            make.height.equalTo(50*AutoSizeScaleX)
            make.width.equalTo(130*AutoSizeScaleX)
        }
    }
    func configSocialMainBGView(){
    let configSocialView = UIView()
    configSocialView.backgroundColor = UIColor.red
    self.configBGView.addSubview(configSocialView)
    self.configSocialView = configSocialView
    configSocialView.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(self.loginnBtn.snp.bottom).offset(40*AutoSizeScaleX)
        make.left.right.equalTo(self.configBGView)
        make.height.equalTo(260*AutoSizeScaleX)
    }
    
    let orContinueWithLabel = UILabel()
    orContinueWithLabel.text = "Or Continue with"
    orContinueWithLabel.textColor = UIColor.white
    orContinueWithLabel.textAlignment = .left
    orContinueWithLabel.font = orContinueWithLabel.font.withSize(16*AutoSizeScaleX)
    configSocialView.addSubview(orContinueWithLabel)
    orContinueWithLabel.snp.makeConstraints { (make) -> Void in
    make.top.equalTo(configSocialView).offset(20*AutoSizeScaleX)
    make.left.right.equalTo(configSocialView).offset(20*AutoSizeScaleX)
    make.height.equalTo(40*AutoSizeScaleX)
    }
        
        let facebookBtn = UIButton(type: .custom)
       // facebookBtn.setImage(UIImage(named: "facebook1"), for: .normal)
        facebookBtn.setBackgroundImage(UIImage(named: "facebook1"), for: .normal)
        facebookBtn.titleLabel?.font = .systemFont(ofSize:16*AutoSizeScaleX)
        facebookBtn.setTitleColor(UIColor.white, for: .normal)
        facebookBtn.contentHorizontalAlignment = .center
        facebookBtn.clipsToBounds = true
        facebookBtn.addTarget(self, action:#selector(self.facebookSignInCustomBtn), for: .touchUpInside)
        self.configSocialView.addSubview(facebookBtn)
        facebookBtn.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(orContinueWithLabel).offset(-6*AutoSizeScaleX)
            make.top.equalTo(orContinueWithLabel).offset(40*AutoSizeScaleX)
            make.height.width.equalTo(40*AutoSizeScaleX)
        }
        
        let gmailBtn = UIButton(type: .custom)
        //gmailBtn.setImage(UIImage(named: "googleImagee"), for: .normal)
        gmailBtn.setBackgroundImage(UIImage(named: "googleImg"), for: .normal)
        gmailBtn.titleLabel?.font = .systemFont(ofSize:16*AutoSizeScaleX)
        gmailBtn.setTitleColor(UIColor.white, for: .normal)
        gmailBtn.contentHorizontalAlignment = .center
        gmailBtn.clipsToBounds = true
        gmailBtn.addTarget(self, action:#selector(self.gmailSignInBtn), for: .touchUpInside)
        self.configSocialView.addSubview(gmailBtn)
        gmailBtn.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(facebookBtn).offset(70*AutoSizeScaleX)
            make.top.width.height.equalTo(facebookBtn)
        }
        
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = "I dont have an account?"
        dontHaveAccountLabel.textColor = .white
        dontHaveAccountLabel.font = dontHaveAccountLabel.font.withSize(18*AutoSizeScaleX)
        self.configSocialView.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(facebookBtn.snp.bottom).offset(50*AutoSizeScaleX)
            make.left.equalTo(orContinueWithLabel.snp.left)
            make.width.equalTo(200*AutoSizeScaleX)
            make.height.equalTo(30*AutoSizeScaleX)
        }
        
        let signUpBtn = UIButton(type: .custom)
        signUpBtn.setTitle("Create Account", for: .normal)
       // signUpBtn.backgroundColor = UIColor.green
        signUpBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        signUpBtn.setTitleColor(UIColor.green, for: .normal)
        signUpBtn.contentHorizontalAlignment = .left
        signUpBtn.clipsToBounds = true
        signUpBtn.addTarget(self, action:#selector(self.createAccountBtn), for: .touchUpInside)
        self.configSocialView.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(dontHaveAccountLabel)
            make.left.equalTo(dontHaveAccountLabel.snp_rightMargin)
            make.height.equalTo(32*AutoSizeScaleX)
            make.width.equalTo(130*AutoSizeScaleX)
        }
        
    }
    @objc func signUpBtn(sender:UIButton!){
        //        let newViewController = CongratulationVC()
        //        self.present(newViewController, animated: true, completion: nil)
    }
    @objc func createAccountBtn(sender:UIButton!){
        let registerVC = RegisterViewController()
        self.present(registerVC, animated: true, completion: nil)

    }
    @objc func forgotPwdBtn(sender:UIButton!){
        
    }
    @objc func loginBtn(sender:UIButton!){
        if (mobileNoTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
            showAlert(for: "Please fill the all details")
            
        }else{
            let mobileVerigyVC = HomeViewController()
            self.present(mobileVerigyVC, animated: true, completion: nil)
        }
    }
    @objc func facebookSignInCustomBtn(sender:UIButton!){
        if Connectivity.isConnectedToInternet {
           
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            showAlert(for: "Not connected")
        }
        
    }
    @objc func gmailSignInBtn(sender: UIButton!) {
        if Connectivity.isConnectedToInternet {
            let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading"
            GIDSignIn.sharedInstance()?.signIn()
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            showAlert(for: "Not connected")
        }
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
extension SkyFloatingLabelTextField{
    
    func CustomTextField(){
        
        tintColor = overcastBlueColor // the color of the blinking cursor
        textColor = whiteSmokeColor
        //lineColor = lightGreyColor
        selectedTitleColor = overcastBlueColor
        selectedLineColor = overcastBlueColor
       // lineHeight = 1.0*AutoSizeScaleX // bottom line height in points
        selectedLineHeight = 2.0*AutoSizeScaleX
        
    }
}
open class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
