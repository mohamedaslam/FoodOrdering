//
//  FacebookGmailMobileVC.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/12/3.
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

class FacebookGmailMobileVC: UIViewController,UITextFieldDelegate {
    var configBGView = UIView()
    var configGetOTPBGView = UIView()
    var userNameLabel = UILabel()
    
    var mobileNoTextField = SkyFloatingLabelTextField()
    var getUserName : String = ""

    
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34.0*AutoSizeScaleX)
        configBGView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(configBGView).offset(30*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
        let userNameLabel = UILabel()
        userNameLabel.text = self.getUserName
        userNameLabel.textColor = UIColor.black
        userNameLabel.textAlignment = .left
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 32.0*AutoSizeScaleX)
        configBGView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(titleLabel.snp.bottom).offset(30*AutoSizeScaleX)
                make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
                make.height.equalTo(40*AutoSizeScaleX)
        }
        let youAreOneStepLabel = UILabel()
        youAreOneStepLabel.text = "You are one step away to get your Quality Food Experience"
        youAreOneStepLabel.textColor = UIColor.black
        youAreOneStepLabel.textAlignment = .left
        youAreOneStepLabel.numberOfLines = 0
        youAreOneStepLabel.font = UIFont.boldSystemFont(ofSize: 35.0*AutoSizeScaleX)
        configBGView.addSubview(youAreOneStepLabel)
        youAreOneStepLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(userNameLabel.snp.bottom).offset(24*AutoSizeScaleX)
                make.left.equalTo(configBGView).offset(20*AutoSizeScaleX)
                make.right.equalTo(configBGView).offset(-50*AutoSizeScaleX)
                make.height.equalTo(200*AutoSizeScaleX)
        }
        let mobileNoTextField = SkyFloatingLabelTextField()
        mobileNoTextField.placeholder = "Enter Mobile Number"
        mobileNoTextField.CustomTextField()
        mobileNoTextField.font = UIFont.boldSystemFont(ofSize: 28.0*AutoSizeScaleX)
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
            make.top.equalTo(youAreOneStepLabel.snp_bottomMargin).offset(20*AutoSizeScaleX)
            make.left.equalTo(titleLabel)
            make.right.equalTo(configBGView).offset(-20*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
       
        let letGetStartBtn = UIButton(type: .custom)
        // facebookBtn.setBackgroundImage(UIImage(named: "facebookImg"), for: .normal)
        letGetStartBtn.setTitle("Let`s Get Started", for: .normal)
        letGetStartBtn.titleLabel?.font = .systemFont(ofSize:20*AutoSizeScaleX)
        letGetStartBtn.setTitleColor(whiteSmokeColor, for: .normal)
        letGetStartBtn.backgroundColor = UIColor.black
        letGetStartBtn.contentHorizontalAlignment = .center
        letGetStartBtn.clipsToBounds = true
        letGetStartBtn.addTarget(self, action:#selector(self.letgetStartBtn), for: .touchUpInside)
        self.configBGView.addSubview(letGetStartBtn)
        letGetStartBtn.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(mobileNoTextField)
            make.top.equalTo(mobileNoTextField.snp.bottom).offset(30*AutoSizeScaleX)
            make.width.equalTo(180*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        
    }
  @objc func letgetStartBtn(sender:UIButton!){
    
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
               if(updatedText.count == 11){
                              print("CALL ALI")
                              sendOTPApiCalling()
                             
                          }
           
               return updatedText.count <= 10
               
           }
           return true
       }
    func sendOTPApiCalling(){
             
                  let parameters: Parameters=[
                    "mobileNumber": self.mobileNoTextField.text!
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
                             let mobileVerigyVC = MobileVerifyViewController()
                                mobileVerigyVC.mobileNumberLabel.text = self.mobileNoTextField.text
                                mobileVerigyVC.userNameLabel.text = self.getUserName
                               // mobileVerigyVC.passwordTextField.text = self.passwordTextField.text
                                self.present(mobileVerigyVC, animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
