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
    var mobileNoStr : String = ""
    var mobileNoTextField = SkyFloatingLabelTextField()
    var getOTPStr : String = ""
    //////////TIMER
      var count = 180  // 60sec if you want
      var resendTimer = Timer()
      // MARK: - Variables
      var resendBtn = UIButton()
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
               txtOTPView.isBottomLineTextField = true
        txtOTPView.borderColorTextField = .black
        txtOTPView.borderWidthTextField = 3
        txtOTPView.selectedBorderColorTextField = .blue
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
        self.configVerifyBGView.addSubview(txtOTPView)
        txtOTPView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configVerifyBGView).offset(40*AutoSizeScaleX)
            make.left.right.equalTo(self.configBGView)
            make.height.equalTo(100*AutoSizeScaleX)
            }
       
        
    }
    @objc func resendOTPBtn(sender:UIButton!){
                  sendOTPApiCalling()
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
    func sendOTPApiCalling(){
                   count = 180
                        let parameters: Parameters=[
                           "mobileNumber": mobileNoStr
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
              noteOTPLabel.textColor = .black
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
        reSendverifyOTPApi()

        }
    func configCreateAccountBGView(){
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = "I dont have an account?"
        dontHaveAccountLabel.textColor = .black
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
        signUpBtn.setTitleColor(UIColor.black, for: .normal)
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
        byCountiuingLabel.textColor = .black
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
     func reSendverifyOTPApi(){
            
            let parameters: Parameters=[
                "mobileNumber": "9632845812"
            ]
            
            Alamofire.request(URL_USER_RESEND_OTP, method: .post, parameters: parameters,encoding:JSONEncoding.default, headers: nil).responseJSON
                {
                    response in
                    switch response.result {
                    case .success:
                        print(response)
                        if let result = response.result.value{
                            print(result)
                            print("result")
                            let swiftyJsonVar = JSON(result)
                            if let status = swiftyJsonVar["status"].bool{
                                if(status){
//                           if let statusMessage = swiftyJsonVar["statusMessage"].string{
//                               ///LOGIN SUCCESS
//                                if(statusMessage == "Invalid OTP"){
                                   let alertController = UIAlertController(title: "OTP send to Registered Mobile Number", message: swiftyJsonVar["statusMessage"].string, preferredStyle: .alert)
                                   let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                   UIAlertAction in
                                    self.configVerifyBGView.isHidden = false
                                    self.configGetBGView.isHidden = true
                                    self.resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                                                let resendBtn = UIButton(type: .custom)
                                                       resendBtn.setTitle("0:0", for: .normal)
                                                       resendBtn.backgroundColor = UIColor.lightGray
                                                      // resendBtn.layer.cornerRadius = 20
                                                       resendBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
                                                       resendBtn.setTitleColor(UIColor.white, for: .normal)
                                                       resendBtn.contentHorizontalAlignment = .center
                                                       resendBtn.clipsToBounds = true
                                                       resendBtn.addTarget(self, action:#selector(self.resendOTPBtn), for: .touchUpInside)
                                                       self.configBGView.addSubview(resendBtn)
                                                self.resendBtn = resendBtn
                                                       resendBtn.snp.makeConstraints{(make) -> Void in
                                                        make.top.equalTo(self.txtOTPView.snp.bottom).offset(10*AutoSizeScaleX)
                                                        make.centerX.equalTo(self.configBGView)
                                                           make.height.equalTo(40*AutoSizeScaleX)
                                                           make.width.equalTo(150*AutoSizeScaleX)
                                                       }
                                   }
                             alertController.addAction(okAction)
                             self.present(alertController, animated: true, completion: nil)
                                }else{
                               //LOGIN FAIL
                                   let alertController = UIAlertController(title: "Invalid OTP", message: nil, preferredStyle: .alert)
                                                                  let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                                                  UIAlertAction in
                                                  // self.configVerifyBGView.isHidden = false
                                                // self.configGetBGView.isHidden = true
                                                                  }
                                                            alertController.addAction(okAction)
                                                            self.present(alertController, animated: true, completion: nil)                           }
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
                              //  self.showAlert(for: "Server Down")
                                return
                            }
                        } else {
                            message = error.localizedDescription
                            print(message)
                            print("messagemessage DEhttpStatusCode")
                            //self.showAlert(for: "Server Down")
                        }
                    }
            }
        }
    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    func buttonAction() {
        let textView = UITextView()
        textView.frame = CGRect(x: 10, y: 50, width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT * 2)
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 20, height: textView.contentSize.height))
        lab.backgroundColor = UIColor.white
        lab.font = textView.font
        lab.textColor = UIColor.black
        lab.numberOfLines = 0
        lab.text = textView.text
        textView.addSubview(lab)

        UIGraphicsBeginImageContextWithOptions(CGSize(width: SCREEN_WIDTH - 20, height: textView.contentSize.height), _: true, _: 1)
        if let context = UIGraphicsGetCurrentContext() {
            lab.layer.render(in: context)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        textView.frame = CGRect(x: 10, y: 50, width: SCREEN_WIDTH - 20, height: SCREEN_HEIGHT * 2)
        lab.removeFromSuperview()

    }
  

   func forgotPwdApi(){
               
                 let parameters: Parameters=[
                     "mobileNumber": mobileNoStr,
                     "otp": getOTPStr,
                     "newPassword": ""
                 ]
                 
                 Alamofire.request(URL_USER_FORGOT_PWD, method: .post, parameters: parameters,encoding:JSONEncoding.default, headers: nil).responseJSON
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
                                        let alertController = UIAlertController(title: "OTP Verified Successfully", message: nil, preferredStyle: .alert)
                                                                       let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                                                       UIAlertAction in
                                                     let changeVC = ChangePwdViewController()
                                                                        changeVC.getMobileNo = self.mobileNoStr
                                                                        changeVC.getOTPStr = self.getOTPStr
                                                     self.present(changeVC, animated: true, completion: nil)
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
}
extension ForgotPwdViewController : DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        print("addText:- " + text + " at:- \(position)" )
        getOTPStr = text
         if(position == 3){
                    forgotPwdApi()
        //            let changePwdVC = ChangePwdViewController()
        //            changePwdVC.getOTPStr = getOTPStr
        //            changePwdVC.getMobileNo = mobileNoStr
        //             self.present(changePwdVC, animated: true, completion: nil)
                }
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
        if(position == 3){
            forgotPwdApi()
//            let changePwdVC = ChangePwdViewController()
//            changePwdVC.getOTPStr = getOTPStr
//            changePwdVC.getMobileNo = mobileNoStr
//             self.present(changePwdVC, animated: true, completion: nil)
        }
    }
    func dpOTPViewBecomeFirstResponder() {
        
    }
    func dpOTPViewResignFirstResponder() {
        
    }
}
