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
import FBSDKLoginKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import SkyFloatingLabelTextField
import MBProgressHUD
import SystemConfiguration
import SnapKit

class LoginViewController: UIViewController,UITextFieldDelegate,LoginButtonDelegate,GIDSignInDelegate {
    var configBGView = UIView()
    var configSocialView = UIView()
    var configPwdForgotPwdView = UIView()
    var tickImageView = UIImageView()
    var dict : [String : AnyObject]!
    var getFullName : String = ""
    var getEmailId : String = ""
    var mobileNoTextField = SkyFloatingLabelTextField()
    var passwordTextField = SkyFloatingLabelTextField()
    var loginnBtn = UIButton()
    var notRegisteredLabel = UILabel()
    var loadingIndication = MyIndicator(frame: CGRect(x: 0, y: 0, width: 50 , height: 50), image: UIImage(named: "loading1")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        ////////GMAIL
         GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
       // GIDSignIn.sharedInstance()?.restorePreviousSignIn()

        configMainBGView()
        configPwdForgotPWdSingBtnBGView()
        configSocialMainBGView()
        configCreateAccountBGView()
        self.addDoneButtonOnKeyboard()

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
        mobileNoTextField.backgroundColor = UIColor.clear
        mobileNoTextField.font = UIFont.boldSystemFont(ofSize: 24.0*AutoSizeScaleX)
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
            make.right.equalTo(configBGView).offset(-100*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        
        let loadingImageBGView = UIView()
        loadingImageBGView.backgroundColor = UIColor.clear
        self.configBGView.addSubview(loadingImageBGView)
        loadingImageBGView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(mobileNoTextField)
            make.left.equalTo(mobileNoTextField.snp.right)
            make.width.height.equalTo(50)
        }
        tickImageView = UIImageView()
        tickImageView.image = UIImage(named: "tickmark")
        tickImageView.isHidden = true
        loadingImageBGView.addSubview(tickImageView)
        tickImageView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalTo(loadingImageBGView)
        }

        loadingImageBGView.addSubview(loadingIndication)
        loadingIndication.isHidden = true
        
        let notRegisteredLabel = UILabel()
        notRegisteredLabel.text = "Sorry! this number is not registered with us Please check your number again or Re-Enter"
        notRegisteredLabel.textColor = UIColor.red
        notRegisteredLabel.textAlignment = .left
        notRegisteredLabel.isHidden = true
        notRegisteredLabel.numberOfLines = 0
        notRegisteredLabel.font = notRegisteredLabel.font.withSize(16*AutoSizeScaleX)
        self.configBGView.addSubview(notRegisteredLabel)
        self.notRegisteredLabel = notRegisteredLabel
        notRegisteredLabel.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(mobileNoTextField.snp.bottom).offset(10*AutoSizeScaleX)
        make.left.equalTo(configBGView).offset(20*AutoSizeScaleX)
        make.right.equalTo(configBGView).offset(-40*AutoSizeScaleX)
        make.height.equalTo(60*AutoSizeScaleX)
        }
       
    }
    func configPwdForgotPWdSingBtnBGView(){
        let configPwdForgotPwdView = UIView()
        configPwdForgotPwdView.backgroundColor = UIColor.clear
        self.configBGView.addSubview(configPwdForgotPwdView)
        self.configPwdForgotPwdView = configPwdForgotPwdView
        self.configPwdForgotPwdView.isHidden = true
        configPwdForgotPwdView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.mobileNoTextField.snp.bottom).offset(30*AutoSizeScaleX)
            make.left.right.equalTo(self.configBGView)
            make.height.equalTo(200*AutoSizeScaleX)
        }
        
        let passwordTextField = SkyFloatingLabelTextField()
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.CustomTextField()
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 24.0*AutoSizeScaleX)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.textAlignment = .left
        passwordTextField.placeholderColor = UIColor.lightGray
        passwordTextField.delegate = self
        self.configPwdForgotPwdView.addSubview(passwordTextField)
        self.passwordTextField = passwordTextField
        
        passwordTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(configPwdForgotPwdView)
            make.left.equalTo(mobileNoTextField)
            make.right.equalTo(mobileNoTextField)
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
        self.configPwdForgotPwdView.addSubview(forgotPwdBtn)
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
        self.configPwdForgotPwdView.addSubview(loginBtn)
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
    configSocialView.backgroundColor = UIColor.clear
    self.configBGView.addSubview(configSocialView)
    self.configSocialView = configSocialView
    self.configSocialView.isHidden = false
    configSocialView.snp.makeConstraints { (make) -> Void in
        make.top.equalTo(self.mobileNoTextField.snp.bottom).offset(50*AutoSizeScaleX)
        make.left.right.equalTo(self.configBGView)
        make.height.equalTo(200*AutoSizeScaleX)
    }
    
    let orContinueWithLabel = UILabel()
    orContinueWithLabel.text = "Or Continue with"
    orContinueWithLabel.textColor = UIColor.black
    orContinueWithLabel.textAlignment = .left
    orContinueWithLabel.font = orContinueWithLabel.font.withSize(15*AutoSizeScaleX)
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
            make.top.equalTo(orContinueWithLabel).offset(50*AutoSizeScaleX)
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
        
    }
    func configCreateAccountBGView(){
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.text = "I dont have an account?"
        dontHaveAccountLabel.textColor = .black
        dontHaveAccountLabel.font = dontHaveAccountLabel.font.withSize(16*AutoSizeScaleX)
        self.configBGView.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(self.configBGView.snp.bottom).offset(-180*AutoSizeScaleX)
            make.left.equalTo(self.mobileNoTextField.snp.left)
            make.width.equalTo(180*AutoSizeScaleX)
            make.height.equalTo(30*AutoSizeScaleX)
        }
        
        let signUpBtn = UIButton(type: .custom)
        signUpBtn.setTitle("Create Account", for: .normal)
        signUpBtn.titleLabel?.font = .systemFont(ofSize:16*AutoSizeScaleX)
        signUpBtn.setTitleColor(UIColor.black, for: .normal)
        signUpBtn.contentHorizontalAlignment = .left
        signUpBtn.clipsToBounds = true
        signUpBtn.addTarget(self, action:#selector(self.createAccountBtn), for: .touchUpInside)
        self.configBGView.addSubview(signUpBtn)
        signUpBtn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(dontHaveAccountLabel)
            make.left.equalTo(dontHaveAccountLabel.snp.right)
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
    func deleteApiCalling(){
        
  
        Alamofire.request(URL_USER_DELETE, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON
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
                       
//                            let alertController = UIAlertController(title: "Registration Success", message: "swiftyJsonVar", preferredStyle: .alert)
//                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//                                UIAlertAction in
//                                
//                            }
//                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//                                UIAlertAction in
//                                NSLog("Cancel Pressed")
//                            }
//                            
//                            // Add the actions
//                            alertController.addAction(okAction)
//                            alertController.addAction(cancelAction)
//                            self.present(alertController, animated: true, completion: nil)
//                            MBProgressHUD.hide(for: self.view, animated: true)
//                            
                        
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
    @objc func signUpBtn(sender:UIButton!){
        //        let newViewController = CongratulationVC()
        //        self.present(newViewController, animated: true, completion: nil)
    }
    @objc func createAccountBtn(sender:UIButton!){
        let registerVC = RegisterViewController()
        self.present(registerVC, animated: true, completion: nil)

    }
    @objc func forgotPwdBtn(sender:UIButton!){
         let forgotPwdVC = ForgotPwdViewController()
        forgotPwdVC.mobileNoStr = self.mobileNoTextField.text!
        self.present(forgotPwdVC, animated: true, completion: nil)
    }
    @objc func loginBtn(sender:UIButton!){
        if (mobileNoTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
            showAlert(for: "Please fill the all details")
            
        }else{
           // let mobileVerigyVC = HomeViewController()
           // self.present(mobileVerigyVC, animated: true, completion: nil)
            loginApiCalling()
        }
    }
//    @objc func facebookSignInCustomBtn(sender:UIButton!){
//        deleteApiCalling()
//        if Connectivity.isConnectedToInternet {
//
//        }else{
//            MBProgressHUD.hide(for: self.view, animated: true)
//            showAlert(for: "Not connected")
//        }
//
//    }
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
        self.passwordTextField.inputAccessoryView = doneToolbar
        
    }
    @objc func doneButtonAction()
    {
        self.mobileNoTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
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
            if(updatedText.count == 11){
                print("CALL ALI")
                checkMobileNumberApi()
               
            }
            if(updatedText.count < 10){
                self.configSocialView.isHidden = false
                self.configPwdForgotPwdView.isHidden = true
                self.tickImageView.isHidden = true
                self.notRegisteredLabel.isHidden = true

            }
            return updatedText.count <= 10
            
        }
        return true
    }
    func checkMobileNumberApi(){
         print(self.mobileNoTextField.text!)
        loadingIndication.startAnimating()
 Alamofire.request("http://heimeyapi-dev.ap-south-1.elasticbeanstalk.com/api/Users/GetUser?mobileno=\(self.mobileNoTextField.text!)", method: .get,encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
           // debugPrint(response)
            switch response.result {
            case .success:
                if let result = response.result.value{
                    print(result)

                    let swiftyJsonVar = JSON(result)
                    print(swiftyJsonVar)

                    if let getStatusMsg = swiftyJsonVar["statusMessage"].string{
                        if(getStatusMsg == "Sorry! this number is not registered with us Please check your number again or Re-Ented"){
                            self.tickImageView.isHidden = true
                            self.loadingIndication.stopAnimating()
                            self.configSocialView.isHidden = false
                            self.configPwdForgotPwdView.isHidden = true
                            self.notRegisteredLabel.isHidden = false
                        }else{
                           self.tickImageView.isHidden = false
                           self.loadingIndication.stopAnimating()
                           self.configSocialView.isHidden = true
                           self.configPwdForgotPwdView.isHidden = false
                           self.notRegisteredLabel.isHidden = true

                        }
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    
                }
            case .failure(let error):
                print("FAILURE")
                print(response.response)
               
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    func loginApiCalling(){
         let parameters: Parameters=[
            "mobileNumber": self.mobileNoTextField.text,
            "password": self.passwordTextField.text
         ]
         let headers: HTTPHeaders = ["Content-Type": "application/json"]
         Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON
             {
                 response in
                 switch response.result {
                 case .success:
                     print(response)
                     if let result = response.result.value{
                         let swiftyJsonVar = JSON(result)
                         if let statusMessage = swiftyJsonVar["statusMessage"].string{
                            ///LOGIN SUCCESS
                             if(statusMessage == "Login Successfull!"){
                                if let getuserr = swiftyJsonVar["user"].dictionary{
                                    if let getToken = getuserr["accessToken"]!.string{
                                        let keychain = KeychainSwift()
                                        MBProgressHUD.hide(for: self.view, animated: true)
                                        keychain.set(getToken, forKey: "Token")
                                    }
                                    if let getUserId = getuserr["userKey"]!.string{
                                        let keychain = KeychainSwift()
                                        keychain.set(getUserId, forKey: "UserKey")
                                    }
                                }
                                 let homeVC = HomeViewController()
                                 self.present(homeVC, animated: false, completion: nil)
                             }
                            //LOGIN FAIL
                            if(statusMessage == "Please enter correct password"){
                                self.showAlert(for: statusMessage)
                            }
                             MBProgressHUD.hide(for: self.view, animated: true)
                         }
                         
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
    @objc func facebookSignInCustomBtn(sender:UIButton!){
       // let facebookgmailVC = FacebookGmailMobileVC()
       // self.present(facebookgmailVC, animated: true, completion: nil)
         if Connectivity.isConnectedToInternet {
             let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
             loadingNotification.mode = MBProgressHUDMode.indeterminate
             loadingNotification.label.text = "Loading"
            let fbLoginManager : LoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["email"], from: self, handler: { (result, error) -> Void in
                 if error != nil{
                 } else if (result?.isCancelled)! {
                     MBProgressHUD.hide(for: self.view, animated: true)
                 }
                 else{
                    let loginResult : LoginManagerLoginResult = result!
                     if loginResult.grantedPermissions == nil{
                         return
                     }
                     if (loginResult.grantedPermissions.contains("email")){
                        self.getFBUserData()
                         fbLoginManager.logOut()
                     }
                 }
             })
         }else{
             MBProgressHUD.hide(for: self.view, animated: true)
             showAlert(for: "Not connected")
         }
    
     }
    func getFBUserData(){
        if((AccessToken.current) != nil){
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                   if (error == nil){
                       self.dict = (result as! [String : AnyObject])
                       let swiftyJsonVar = JSON(result as! [String : AnyObject])
                       if let getemail = swiftyJsonVar["email"].string{
                           print(getemail)
                           self.getEmailId = getemail
                           
                       }
                       if let getname = swiftyJsonVar["name"].string{
                           print(getname)
                           self.getFullName = getname
                           self.signupApiCalling()
                       }
                   }
               })
           }
       }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
           print("Did log out of facebook")
       }
       
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
           if error != nil {
            print(error as Any)
               return
           }
           
           print("Successfully logged in with facebook...")
       }
    private func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //   UIActivityIndicatorView.stopAnimating()
    }
    
    private func signIn(signIn: GIDSignIn!,presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
  
    private func signIn(signIn: GIDSignIn!,
                        dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
            print("CANCEL")
            MBProgressHUD.hide(for: self.view, animated: true)
            
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            getEmailId = email!
            getFullName = fullName!
            signupApiCalling()
            print(userId!)
            print(idToken!)
            print(fullName!)
            print(givenName!)
            print(familyName!)
            print(email!)
            print("USER")
            
            
        }
    }
     func signupApiCalling(){
           
                let parameters: Parameters=[
                    "fullName": self.getFullName,
                    "mobileNumber": "",
                    "email": self.getEmailId,
                    "password": "",
                    "isSocialSignUp" : true
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
                                    mobileVerigyVC.userNameLabel.text = self.getFullName
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

                                    }
                                    //LOGIN FAIL
    //                            if(statusMessage == "Please enter correct password"){
    //                            self.showAlert(for: statusMessage)
    //                            }
                                MBProgressHUD.hide(for: self.view, animated: true)
                                }else{
                                    let facebookandGmailVerifyVC = FacebookGmailMobileVC()
                                   facebookandGmailVerifyVC.getUserName = self.getFullName
                                   self.present(facebookandGmailVerifyVC, animated: true, completion: nil)
                                   // self.showAlert(for: "Please enter valid mobile Number")

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
}

extension SkyFloatingLabelTextField{
    
    func CustomTextField(){
        lineHeight = 0
        selectedLineHeight = 0
        tintColor = overcastBlueColor // the color of the blinking cursor
        textColor = whiteSmokeColor
        //lineColor = lightGreyColor
        selectedTitleColor = overcastBlueColor
       // selectedLineColor = overcastBlueColor
       // lineHeight = 1.0*AutoSizeScaleX // bottom line height in points
       // selectedLineHeight = 2.0*AutoSizeScaleX
        
    }
}
open class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
extension String {
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
}


class MyIndicator: UIView {
    
    let imageView = UIImageView()
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        
        imageView.frame = bounds
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(imageView)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func startAnimating() {
        isHidden = false
        rotate()
    }
    
    func stopAnimating() {
        isHidden = true
        removeRotation()
    }
    
    private func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.imageView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    private func removeRotation() {
        self.imageView.layer.removeAnimation(forKey: "rotationAnimation")
    }
}
/*
 let parameters: Parameters=[
    "mobileNumber": "9632845812",
    "password": "Aslam123"
 ]
 
                              SUCCESS: {
                                  status = 0;
                                  statusMessage = "Please enter correct password";
                              }
                              */
                             
                             /*
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
                              status = 1;
                              statusMessage = "Login Successfull!";
                              user =     {
                                  accessToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6Ikk5aE5NNno2VjgtMTUxMTVQMWtFeGciLCJ0eXAiOiJhdCtqd3QifQ.eyJuYmYiOjE1NzUzNTIyMDYsImV4cCI6MTU3NTM1NTgwNiwiaXNzIjoiaHR0cDovL2lkZW50aXR5c2VydmVyLWRldi5hcC1zb3V0aC0xLmVsYXN0aWNiZWFuc3RhbGsuY29tIiwiYXVkIjoiYXBpMSIsImNsaWVudF9pZCI6ImNsaWVudCIsInNjb3BlIjpbImFwaTEiXX0.iEJvRx09XQZjF_Idn8Vwg8gv9iK4A1yLFzkZmXcQPIfhSYMaUbCcuaBfA4OlOlXlWrAKAY3exnST4uyeVODKwAKmBPROmX0Zp7PBg-VxmmcJa0Cp0pLl8lWyXsOXgM5MkzoEwxnkm3i5DC04u2qzbrnWQl_AlQKB9haSdz-s_CwQHmrMgQhtpqtyr2NBmX_dDuu7x1b3ugIaRntiZmUi30BxojwegXlrVRSSZXZEGmEgnGD1rQlSCQi54EceM-fOtkRT1zSY9ihVI-WbnH2-VfIFAhSfZ0Y3v_YsClmtO9XP7PQ2cyhmQDHMalTa3mGJPWZHMzvfTSod3UU2_88O8w";
                                  userKey = "a939b505-7782-4092-968a-0d811b58bb69";
                              };
                              */
