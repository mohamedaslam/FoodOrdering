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
        self.addDoneButtonOnKeyboard()

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
            make.top.equalTo(configBGView).offset(60*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
        let mobileNoTextField = SkyFloatingLabelTextField()
        mobileNoTextField.placeholder = "Enter Mobile Number"
        mobileNoTextField.CustomTextField()
        mobileNoTextField.font = UIFont.boldSystemFont(ofSize: 26.0*AutoSizeScaleX)
        mobileNoTextField.borderStyle = UITextField.BorderStyle.none
        mobileNoTextField.autocorrectionType = UITextAutocorrectionType.no
        mobileNoTextField.keyboardType = UIKeyboardType.numberPad
        mobileNoTextField.returnKeyType = UIReturnKeyType.done
        mobileNoTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        mobileNoTextField.textAlignment = .left
        mobileNoTextField.placeholderColor = UIColor.lightGray
        mobileNoTextField.delegate = self
        self.configBGView.addSubview(mobileNoTextField)
        self.mobileNoTextField = mobileNoTextField
        
        mobileNoTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(50*AutoSizeScaleX)
            make.left.equalTo(titleLabel)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let fullNameTextField = SkyFloatingLabelTextField()
        fullNameTextField.placeholder = "Full Name"
        fullNameTextField.CustomTextField()
        fullNameTextField.font = UIFont.boldSystemFont(ofSize: 26.0*AutoSizeScaleX)
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
            make.top.equalTo(mobileNoTextField.snp_bottomMargin).offset(30*AutoSizeScaleX)
            make.left.equalTo(mobileNoTextField)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        
        let passwordTextField = SkyFloatingLabelTextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.CustomTextField()
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 26.0*AutoSizeScaleX)
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
            make.top.equalTo(fullNameTextField.snp_bottomMargin).offset(30*AutoSizeScaleX)
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
        getOTPBtn.setTitleColor(.white, for: .normal)
        getOTPBtn.backgroundColor = UIColor.black
        getOTPBtn.contentHorizontalAlignment = .center
        getOTPBtn.clipsToBounds = true
        getOTPBtn.addTarget(self, action:#selector(self.getOTPBtn), for: .touchUpInside)
        self.configGetOTPBGView.addSubview(getOTPBtn)
        getOTPBtn.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(configGetOTPBGView).offset(20*AutoSizeScaleX)
            make.top.equalTo(configGetOTPBGView).offset(20*AutoSizeScaleX)
            make.width.equalTo(100*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        
      
        
        let noteOTPLabel = UILabel()
        noteOTPLabel.text = "Note:-OTP will be sent to the above mentioned number."
        noteOTPLabel.textColor = .black
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
        dontHaveAccountLabel.textColor = .black
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
        signUpBtn.setTitleColor(UIColor.black, for: .normal)
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
            signupApiCalling()

//            let mobileVerigyVC = MobileVerifyViewController()
//            mobileVerigyVC.mobileNumberLabel.text = mobileNoTextField.text
//            mobileVerigyVC.userNameLabel.text = fullNameTextField.text
//            mobileVerigyVC.passwordTextField.text = passwordTextField.text
//            self.present(mobileVerigyVC, animated: true, completion: nil)
        }
        
       
    }

    @objc func signInBtn(sender:UIButton!){
      //  signupApiCalling()
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
    func addDoneButtonOnKeyboard()
      {
          let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
          doneToolbar.barStyle = UIBarStyle.default
          
          let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
          let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
          
          var items = [UIBarButtonItem]()
          items.append(flexSpace)
          items.append(done)
          
          doneToolbar.items = items
          doneToolbar.sizeToFit()
          
          self.mobileNoTextField.inputAccessoryView = doneToolbar
          self.fullNameTextField.inputAccessoryView = doneToolbar
          self.passwordTextField.inputAccessoryView = doneToolbar

      }
    @objc func doneButtonAction()
      {
          self.mobileNoTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.fullNameTextField.resignFirstResponder()

      }
      func signupApiCalling(){
       
            let parameters: Parameters=[
                "fullName": self.fullNameTextField.text!,
                "mobileNumber": self.mobileNoTextField.text!,
                "password": self.passwordTextField.text!,
                "isSocialSignUp" : false,
                "email": ""
            ]
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: nil).responseJSON
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
                                                       ///LOGIN SUCCESS
                            if(status){
                            let alertController = UIAlertController(title: "REGISTERED SUCCESSFULL", message: swiftyJsonVar["statusMessage"].string, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                            let mobileVerigyVC = MobileVerifyViewController()
                            mobileVerigyVC.mobileNumberLabel.text = self.mobileNoTextField.text
                            mobileVerigyVC.userNameLabel.text = self.fullNameTextField.text
                            mobileVerigyVC.passwordTextField.text = self.passwordTextField.text
                            self.present(mobileVerigyVC, animated: true, completion: nil)
                                        }
                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                        UIAlertAction in
                                        NSLog("Cancel Pressed")
                            }
                                        // Add the actions
                                    alertController.addAction(okAction)
                                    alertController.addAction(cancelAction)
                                    self.present(alertController, animated: true, completion: nil)
                                    MBProgressHUD.hide(for: self.view, animated: true)
                            }else{
                             self.showAlert(for: "User already Exists")

                                }
                                //LOGIN FAIL
//                            if(statusMessage == "Please enter correct password"){
//                            self.showAlert(for: statusMessage)
//                            }
                            MBProgressHUD.hide(for: self.view, animated: true)
                        }
//                            if let statusValue = swiftyJsonVar["status"].int{
//                                if(statusValue = 400){
//                                    self.showAlert(for: "User already Exists")
//
//                                }
//                            }
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
    //MARK - UITextField Delegates
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           //For mobile numer validation
           if textField == mobileNoTextField {
               let currentText = textField.text ?? ""
               
               // attempt to read the range they are trying to change, or exit if we can't
               guard let stringRange = Range(range, in: currentText) else { return false }
               
               // add their new text to the existing text
               let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
               
               // make sure the result is under 16 characters
               
               return updatedText.count <= 10
               
           }
           return true
       }
    func sendOTPApiCalling(){
          
               let parameters: Parameters=[
                   "mobileNumber": "+919632845812"
               ]
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
}
/*
 {
   "status": true,
   "statusMessage": "User creation successful.8751"
 }
 
 {
   "type" : "https:\/\/tools.ietf.org\/html\/rfc7231#section-6.5.1",
   "traceId" : "|4c3d33e1-470bb6ddd3f18e21.",
   "status" : 400,
   "title" : "One or more validation errors occurred.",
   "errors" : {
     "MobileNumber" : [
       "User already Exists"
     ]
   }
 }
 */
