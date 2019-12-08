//
//  MobileVerifyViewController.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/11/21.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit
import FasterVerificationCode
import KWVerificationCodeView
import Alamofire
import SwiftyJSON
import KeychainSwift
import SkyFloatingLabelTextField
import MBProgressHUD
import SystemConfiguration
import SnapKit

class MobileVerifyViewController: UIViewController,UITextFieldDelegate {
    var configBGView = UIView()
    var configGetOTPBGView = UIView()
    
    let mobileNumberLabel = UILabel()
    let userNameLabel = UILabel()
    var mobileNoTextField = SkyFloatingLabelTextField()
    var fullNameTextField = SkyFloatingLabelTextField()
    var passwordTextField = SkyFloatingLabelTextField()
   // var verificationView = VerificationCodeView()
    var containerView = UIView()
    var txtOTPView: DPOTPView!
    var getOTPStr : String = ""
    var getEmail : String = ""
    //////////TIMER
    var count = 180  // 60sec if you want
    var resendTimer = Timer()
    // MARK: - Variables
    var verificationCodeView: KWVerificationCodeView?
    var resendBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configMainBGView()
        
       
      
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
        titleLabel.font = titleLabel.font.withSize(36)
        configBGView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(configBGView).offset(60*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
         let mobileNoTextField = SkyFloatingLabelTextField()
        mobileNoTextField.text = self.mobileNumberLabel.text
        mobileNoTextField.CustomTextField()
        mobileNoTextField.font = UIFont.boldSystemFont(ofSize: 26.0*AutoSizeScaleX)
        mobileNoTextField.borderStyle = UITextField.BorderStyle.none
        mobileNoTextField.autocorrectionType = UITextAutocorrectionType.no
        mobileNoTextField.keyboardType = UIKeyboardType.numberPad
        mobileNoTextField.returnKeyType = UIReturnKeyType.done
        mobileNoTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        mobileNoTextField.textAlignment = .left
        configBGView.addSubview(mobileNoTextField)
        mobileNoTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(40*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
        let fullNameTextField = SkyFloatingLabelTextField()
        fullNameTextField.text = self.userNameLabel.text
        fullNameTextField.CustomTextField()
        fullNameTextField.font = UIFont.boldSystemFont(ofSize: 26.0*AutoSizeScaleX)
        fullNameTextField.borderStyle = UITextField.BorderStyle.none
        fullNameTextField.autocorrectionType = UITextAutocorrectionType.no
        fullNameTextField.keyboardType = UIKeyboardType.default
        fullNameTextField.returnKeyType = UIReturnKeyType.done
        fullNameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        fullNameTextField.textAlignment = .left
        configBGView.addSubview(fullNameTextField)
        fullNameTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mobileNoTextField.snp.bottom).offset(30*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        let passwordTextField = SkyFloatingLabelTextField()
        passwordTextField.placeholder = ""
       // passwordTextField.backgroundColor = .red
        passwordTextField.CustomTextField()
        passwordTextField.text = self.passwordTextField.text
        passwordTextField.font = UIFont.systemFont(ofSize: 28*AutoSizeScaleX)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.textAlignment = .left
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholderColor = UIColor.black
        passwordTextField.delegate = self
        self.passwordTextField = passwordTextField
        self.configBGView.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(fullNameTextField.snp.bottom).offset(30*AutoSizeScaleX)
            make.left.equalTo(fullNameTextField)
            make.width.equalTo(180*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let pwdViewBtn = UIButton(type: .custom)
               pwdViewBtn.setTitle("View", for: .normal)
               pwdViewBtn.backgroundColor = UIColor.clear
              // loginBtn.layer.cornerRadius = 20
               pwdViewBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
               pwdViewBtn.setTitleColor(UIColor.black, for: .normal)
               pwdViewBtn.contentHorizontalAlignment = .left
               pwdViewBtn.clipsToBounds = true
               pwdViewBtn.addTarget(self, action:#selector(self.viewPwdBtn), for: .touchUpInside)
               self.configBGView.addSubview(pwdViewBtn)
               pwdViewBtn.snp.makeConstraints{(make) -> Void in
                make.top.equalTo(passwordTextField.snp.centerY).offset(-18*AutoSizeScaleX)
                   make.left.equalTo(passwordTextField.snp.right)
                   make.height.equalTo(50*AutoSizeScaleX)
                   make.width.equalTo(80*AutoSizeScaleX)
               }
        let verifyOTPLabel = UILabel()
        verifyOTPLabel.text = "Verify OTP"
        verifyOTPLabel.textColor = UIColor.black
        verifyOTPLabel.textAlignment = .left
        verifyOTPLabel.font = UIFont.boldSystemFont(ofSize: 28*AutoSizeScaleX)
        configBGView.addSubview(verifyOTPLabel)
        verifyOTPLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
        let containerView = UIView()
        self.view.addSubview(containerView)
        self.containerView = containerView
        containerView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(verifyOTPLabel)
            make.width.equalTo(320*AutoSizeScaleX)
            make.height.equalTo(52)
            make.top.equalTo(verifyOTPLabel.snp.bottom)
        }
//        verificationCodeView = KWVerificationCodeView(frame: CGRect(x: 0, y: 0, width: 300, height: 80))
//        verificationCodeView?.digits = 5
//        containerView.addSubview(verificationCodeView!)
        
      txtOTPView = DPOTPView()
        txtOTPView.count = 4
        txtOTPView.isBottomLineTextField = true
        txtOTPView.borderColorTextField = .blue
        txtOTPView.borderWidthTextField = 3
        txtOTPView.selectedBorderColorTextField = .green
        txtOTPView.dismissOnLastEntry = true
        txtOTPView.selectedBorderWidthTextField = 4
        txtOTPView.spacing = 10
        txtOTPView.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(25.0))!
        txtOTPView.dpOTPViewDelegate = self
        txtOTPView.dismissOnLastEntry = true
   
        txtOTPView.isCursorHidden = true
        //        txtOTPView.isSecureTextEntry = true
        //        txtOTPView.isBottomLineTextField = true
        //        txtOTPView.isCircleTextField = true
        self.containerView.addSubview(txtOTPView)
        txtOTPView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.containerView)
            make.left.equalTo(self.containerView)
            make.width.equalTo(250*AutoSizeScaleX)
            make.height.equalTo(80*AutoSizeScaleX)
            }
        
      
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        let resendBtn = UIButton(type: .custom)
               resendBtn.setTitle("0:0", for: .normal)
              // resendBtn.layer.cornerRadius = 20
               resendBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20*AutoSizeScaleX)
               resendBtn.setTitleColor(UIColor.black, for: .normal)
               resendBtn.contentHorizontalAlignment = .left
               resendBtn.clipsToBounds = true
               resendBtn.addTarget(self, action:#selector(self.resendOTPBtn), for: .touchUpInside)
               self.configBGView.addSubview(resendBtn)
        self.resendBtn = resendBtn
               resendBtn.snp.makeConstraints{(make) -> Void in
                   make.top.equalTo(txtOTPView.snp.bottom).offset(10*AutoSizeScaleX)
                   make.left.equalTo(self.containerView)
                   make.height.equalTo(40*AutoSizeScaleX)
                   make.width.equalTo(150*AutoSizeScaleX)
               }
        
//        let loginBtn = UIButton(type: .custom)
//        loginBtn.setTitle("Submit", for: .normal)
//        loginBtn.backgroundColor = UIColor.lightGray
//        loginBtn.layer.cornerRadius = 20
//        loginBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
//        loginBtn.setTitleColor(UIColor.white, for: .normal)
//        loginBtn.contentHorizontalAlignment = .center
//        loginBtn.clipsToBounds = true
//        loginBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
//        self.configBGView.addSubview(loginBtn)
//        loginBtn.snp.makeConstraints{(make) -> Void in
//            make.top.equalTo(resendBtn.snp.bottom).offset(12*AutoSizeScaleX)
//            make.centerX.equalTo(configBGView)
//            make.height.equalTo(40*AutoSizeScaleX)
//            make.width.equalTo(130*AutoSizeScaleX)
//        }
        
        
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = "Already have an account?"
        dontHaveAccountLabel.textColor = .black
        dontHaveAccountLabel.font = dontHaveAccountLabel.font.withSize(18*AutoSizeScaleX)
        self.configBGView.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(configBGView.snp.bottom).offset(-40*AutoSizeScaleX)
            make.left.equalTo(passwordTextField.snp.left)
            make.width.equalTo(208*AutoSizeScaleX)
            make.height.equalTo(30*AutoSizeScaleX)
        }
        
        let signUpBtn = UIButton(type: .custom)
        signUpBtn.setTitle("Sign In", for: .normal)
        signUpBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        signUpBtn.setTitleColor(UIColor.black, for: .normal)
        signUpBtn.contentHorizontalAlignment = .left
        signUpBtn.clipsToBounds = true
        signUpBtn.addTarget(self, action:#selector(self.signInBtn), for: .touchUpInside)
        self.configBGView.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(dontHaveAccountLabel)
            make.left.equalTo(dontHaveAccountLabel.snp.right)
            make.height.equalTo(32*AutoSizeScaleX)
            make.width.equalTo(130*AutoSizeScaleX)
        }
//        let verificationView = VerificationCodeView()
//        verificationView.setLabelNumber(6)
//        verificationView.labelHasBorder = true
//        verificationView.borderHeigth = 1
//        verificationView.labelWidth = 24
//        verificationView.labelSpacing = 16
//        verificationView.labelErrorColor = UIColor.red
//        verificationView.delegate = self
//        self.view.addSubview(verificationView)
//       // self.verificationView = verificationView
//        verificationView.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(passwordTextField).offset(90*AutoSizeScaleX)
//            make.left.right.equalTo(passwordTextField).offset(20*AutoSizeScaleX)
//            make.height.equalTo(40*AutoSizeScaleX)
//        }
        
    }
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60

        // return formated string
        return String(format: "%02i:%02i", minute, second)
    }
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            self.resendBtn.setTitle("\(timeString(time: TimeInterval(count)))", for: .normal)
        }
        else {
            resendTimer.invalidate()
            print("call your api")
            self.resendBtn.setTitle("Resend Otp", for: .normal)
            // if you want to reset the time make count = 60 and resendTime.fire()
        }
    }
    @objc func viewPwdBtn(sender:UIButton!){
        if(self.passwordTextField.isSecureTextEntry == true){
        self.passwordTextField.isSecureTextEntry = false
        }else{
        self.passwordTextField.isSecureTextEntry = true
        }
    }
    @objc func resendOTPBtn(sender:UIButton!){
               sendOTPApiCalling()
    }
    @objc func signInBtn(sender:UIButton!){
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true, completion: nil)
        
    }
    @objc func loginBtn(sender:UIButton!){
        verifyOTPApi()
//        {
//            "mobileNumber": "string",
//            "otp": "string"
//        }
                  //  let changePwdVC = ChangePwdViewController()
                  //  self.present(changePwdVC, animated: true, completion: nil)
    }
    func verifyOTPApi(){
        
        let parameters: Parameters=[
            "mobileNumber": mobileNumberLabel.text!,
            "otp": self.getOTPStr
        ]
        print(parameters)
        Alamofire.request(URL_USER_VERIFY_OTP, method: .post, parameters: parameters,encoding:JSONEncoding.default, headers: nil).responseJSON
            {
                response in
                switch response.result {
                case .success:
                    print(response)
                    if let result = response.result.value{
                        self.resendTimer.invalidate()
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
                            if let getuserr = swiftyJsonVar["user"].dictionary{
                                if let getToken = getuserr["token"]!.string{
                                    let keychain = KeychainSwift()
                                    MBProgressHUD.hide(for: self.view, animated: true)
                                    keychain.set(getToken, forKey: "Token")
                                }
                                if let getUserId = getuserr["userKey"]!.string{
                                    let keychain = KeychainSwift()
                                    keychain.set(getUserId, forKey: "UserKey")
                                }
                            }
                               let alertController = UIAlertController(title: statusMessage, message: nil, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                                              UIAlertAction in
                                                                
                        let homeVC = HomeViewController()
                        self.present(homeVC, animated: true, completion: nil)
                            
                            }
                                                        alertController.addAction(okAction)
                                                        self.present(alertController, animated: true, completion: nil)                           }
                            MBProgressHUD.hide(for: self.view, animated: true)
                        }
                       
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                        
                    }
                case .failure(let error):
                    let message : String
                    self.resendTimer.invalidate()
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
    func sendOTPApiCalling(){
                count = 180
                     let parameters: Parameters=[
                        "mobileNumber": self.mobileNumberLabel.text!
                     ]
           print(parameters)
              Alamofire.request(URL_USER_RESEND_OTP, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON
                         {
                             response in
                             switch response.result {
                             case .success:
                                 print(response)
                                 if let result = response.result.value{
                                     print(result)
                                     print("result")
                                     let swiftyJsonVar = JSON(result)
                                     print(swiftyJsonVar)
                                     print("swiftyJsonVar")
                                     if (swiftyJsonVar).boolValue {
                                         print(swiftyJsonVar)
                                         print("GETOTPgetemail")
                                         MBProgressHUD.hide(for: self.view, animated: true)
                                     }
                                    if let status = swiftyJsonVar["status"].bool{
                                       if(status){
                                            print(" OTP RECIVED")
                                       }else{
                                           print("INVAIDE OTP")
                                       }
                                   }
                                 }
                             case .failure(let error):
                              print(response)
                              print("ERROR response")

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

}
//extension MobileVerifyViewController: VerificationCodeViewDelegate
//{
//    func verificationCodeInserted(_ text: String, isComplete: Bool)
//    {
//        if text == "123456"
//        {
//            let alertVC = UIAlertController(title: "FasterVerificationCode", message: "Code Inserted Succesfully", preferredStyle: .alert)
//            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alertVC.addAction(action)
//            self.present(alertVC, animated: true, completion: nil)
//        } else
//        {
//            // CODE IS WRONG
//            VerificationCodeView.showError = true
//        }
//    }
//    
//    func verificationCodeChanged()
//    {
//        VerificationCodeView.showError = false
//    }
//}
extension MobileVerifyViewController : DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
        getOTPStr = text
        if(position == 3){
            //  forgotPwdApi()
            verifyOTPApi()
        }
        
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
        print("dfdsfs:-\(txtOTPView.text ?? "<#default value#>")")


    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
}
/*
 SUCCESS: {
     status = 1;
     statusMessage = "OTP Verified Successfully";
 }
 */
