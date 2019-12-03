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
    var passwordTextField = SkyFloatingLabelTextField()
   // var verificationView = VerificationCodeView()
    var containerView = UIView()
    var txtOTPView: DPOTPView!
    var getOTPStr : String = ""

    // MARK: - Variables
    var verificationCodeView: KWVerificationCodeView?
    
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
        titleLabel.font = titleLabel.font.withSize(36)
        configBGView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(configBGView).offset(70*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
        let mobileNumberLabel = UILabel()
        mobileNumberLabel.text = self.mobileNumberLabel.text
        mobileNumberLabel.textColor = UIColor.white
        mobileNumberLabel.textAlignment = .left
       // mobileNumberLabel.font = mobileNumberLabel.font.withSize(36)
        mobileNumberLabel.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        configBGView.addSubview(mobileNumberLabel)
        mobileNumberLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel).offset(80*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        let userNameLabel = UILabel()
        userNameLabel.text = self.userNameLabel.text
        userNameLabel.textColor = UIColor.white
        userNameLabel.textAlignment = .left
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
        configBGView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mobileNumberLabel).offset(60*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        let passwordTextField = SkyFloatingLabelTextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.CustomTextField()
        passwordTextField.text = self.passwordTextField.text
        passwordTextField.font = UIFont.systemFont(ofSize: 32*AutoSizeScaleX)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.textAlignment = .left
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholderColor = UIColor.white
        passwordTextField.delegate = self
        self.configBGView.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(userNameLabel.snp.bottom).offset(20*AutoSizeScaleX)
            make.left.equalTo(userNameLabel)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let verifyOTPLabel = UILabel()
        verifyOTPLabel.text = "Verify OTP"
        verifyOTPLabel.textColor = UIColor.white
        verifyOTPLabel.textAlignment = .left
        verifyOTPLabel.font = mobileNumberLabel.font.withSize(32)
        configBGView.addSubview(verifyOTPLabel)
        verifyOTPLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(passwordTextField.snp.bottom).offset(60*AutoSizeScaleX)
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
            make.top.equalTo(verifyOTPLabel.snp.bottom).offset(14*AutoSizeScaleX)
        }
//        verificationCodeView = KWVerificationCodeView(frame: CGRect(x: 0, y: 0, width: 300, height: 80))
//        verificationCodeView?.digits = 5
//        containerView.addSubview(verificationCodeView!)
        
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
        self.containerView.addSubview(txtOTPView)
        txtOTPView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.containerView)
            make.left.equalTo(self.containerView)
            make.width.equalTo(320*AutoSizeScaleX)
            make.height.equalTo(80*AutoSizeScaleX)
            }
        
        
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Submit", for: .normal)
        loginBtn.backgroundColor = UIColor.lightGray
        loginBtn.layer.cornerRadius = 20
        loginBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.contentHorizontalAlignment = .center
        loginBtn.clipsToBounds = true
        loginBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
        self.configBGView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(txtOTPView.snp.bottom).offset(20*AutoSizeScaleX)
            make.centerX.equalTo(configBGView)
            make.height.equalTo(40*AutoSizeScaleX)
            make.width.equalTo(130*AutoSizeScaleX)
        }
        
        
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = "Already have an account?"
        dontHaveAccountLabel.textColor = .white
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
        signUpBtn.setTitleColor(UIColor.green, for: .normal)
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
            "mobileNumber": mobileNumberLabel.text,
            "otp": self.getOTPStr
        ]
        
        Alamofire.request(URL_USER_VERIFY_OTP, method: .post, parameters: parameters,encoding:JSONEncoding.default, headers: nil).responseJSON
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
        
    }
    
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        print("removeText:- " + text + " at:- \(position)" )
    }
    
    func dpOTPViewChangePositionAt(_ position: Int) {
        print("at:-\(position)")
        print("dfdsfs:-\(txtOTPView.text ?? "<#default value#>")")

        if(position == 4){
//            let changePwdVC = ChangePwdViewController()
//             self.present(changePwdVC, animated: true, completion: nil)
        }
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
