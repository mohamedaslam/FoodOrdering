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
    var getOTPStr : String = ""
    var getMobileNo : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configMainBGView()
        // Do any additional setup after loading the view.
    }
    
    func configMainBGView(){
        let configBGView = UIView()
        configBGView.backgroundColor = UIColor.clear
        self.view.addSubview(configBGView)
        self.configBGView = configBGView
        configBGView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.top.equalTo(self.view)
        }
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Numbervalidation")
        self.configBGView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configBGView)
            make.left.equalTo(self.configBGView)
            make.right.equalTo(self.configBGView)
            make.bottom.equalTo(self.configBGView)
        }
        let titleLabel = UILabel()
        titleLabel.text = "Quisiera"
        titleLabel.textColor = UIColor.black
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
        repasswordTextField.isSecureTextEntry = true
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
        createPwdBtn.setTitleColor(.white, for: .normal)
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
        willCreateLaterBtn.setTitleColor(.black, for: .normal)
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
  func forgotPwdApi(){
    let keychain = KeychainSwift()
    var getaccessToken = String()
    var getUserKey = String()
    if let tokenValue = keychain.get("Token"){
        getaccessToken = tokenValue
    }
    if let userKeyValue = keychain.get("UserKey") {
        getUserKey = userKeyValue
    }
                  let parameters: Parameters=[
                      "mobileNumber": getMobileNo,
                      "newPassword": passwordTextField.text!
                  ]
    let headers = [
        "Authorization": "bearer " + getaccessToken,
        "Accept": "application/json"
    ]
    
                  Alamofire.request(URL_USER_FORGOT_PWD, method: .post, parameters: parameters,encoding:JSONEncoding.default, headers: headers).responseJSON
                      {
                          response in
                          switch response.result {
                          case .success:
                              print(response)
                              if let result = response.result.value{
                                  print(result)
                                  print("result")
                                  let swiftyJsonVar = JSON(result)
                                 if let statusMessage = swiftyJsonVar["statusMessage"].string{
                                     ///LOGIN SUCCESS
                                      if(statusMessage == "Invalid OTP"){
                                         let alertController = UIAlertController(title: statusMessage, message: nil, preferredStyle: .alert)
                                         let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                         UIAlertAction in
          //                              let homeVC = HomeViewController()
          //                               self.present(homeVC, animated: true, completion: nil)
                                         }
                                   alertController.addAction(okAction)
                                   self.present(alertController, animated: true, completion: nil)
                                      }
                                     //LOGIN FAIL
                                     if(statusMessage == "OTP Verified Successfully"){
                                         let alertController = UIAlertController(title: statusMessage, message: nil, preferredStyle: .alert)
                                                                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                                                        UIAlertAction in
                                                      let homeVC = HomeViewController()
                                                      self.present(homeVC, animated: true, completion: nil)
                                                                        }
                                                                  alertController.addAction(okAction)
                                                                  self.present(alertController, animated: true, completion: nil)
                                     }
                                     //LOGIN FAIL
                                     if(statusMessage == "New password created Successfully"){
                                         let alertController = UIAlertController(title: statusMessage, message: nil, preferredStyle: .alert)
                                                                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                                                        UIAlertAction in
                                                      let homeVC = HomeViewController()
                                                      self.present(homeVC, animated: true, completion: nil)
                                                                        }
                                                                  alertController.addAction(okAction)
                                                                  self.present(alertController, animated: true, completion: nil)
                                     }
                                      MBProgressHUD.hide(for: self.view, animated: true)
                                  }
                                 
                                  MBProgressHUD.hide(for: self.view, animated: true)
                                  
                                  
                              }
                          case .failure(let error):
                              let message : String
                              if let httpStatusCode = response.response?.statusCode {
                                  switch(httpStatusCode) {
                                  case 400:
                                      message = "Username or password not provided."
                                  case 401:
                                      message = "Incorrect password for user."
                                  default:
                                      print(httpStatusCode)
                                      print("DEhttpStatusCode")
                                      self.showAlert(for: "Server Down")
                                      return
                                  }
                              } else {
                                  message = error.localizedDescription
                                  print(message)
                                  print("messagemessage DEhttpStatusCode")
                                  self.showAlert(for: "Server Down")
                              }
                          }
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

    @objc func createPwdButton(sender:UIButton!){
        if (self.passwordTextField.text?.isEmpty)! || (self.repasswordTextField.text?.isEmpty)!{
            showAlert(for: "Password should not empty")
        }else{
            forgotPwdApi()
        }
       //   self.configVerifyBGView.isHidden = false
        //   self.configGetBGView.isHidden = true
       }
    @objc func willcreateLaterBtn(sender:UIButton!){
        let homeVC = HomeViewController()
        self.present(homeVC, animated: true, completion: nil)
    }
}
