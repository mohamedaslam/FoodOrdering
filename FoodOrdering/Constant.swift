//
//  Constant.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/11/21.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width
let IPHONE_4_7_INCH_WIDTH = 375.0
let IPHONE_4_7_INCH_HEIGHT = 667.0

let AutoSizeScaleX = SCREEN_WIDTH/CGFloat(IPHONE_4_7_INCH_WIDTH)
let AutoSizeScaleY = SCREEN_HEIGHT/CGFloat(IPHONE_4_7_INCH_HEIGHT)

let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
let lightGrayColor = UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
let whiteSmokeColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1.0)
var FETCH_USERS_URL="http://jsonplaceholder.typicode.com/users"
var URL_USER_LOGIN =    "http://heimeyapi-dev.ap-south-1.elasticbeanstalk.com/api/Users/Login"
var URL_USER_FORGOT_PWD = "https://www.bigrockdirtpark.com/api/ForgotPassword"
var URL_USER_REGISTER = "http://heimeyapi-dev.ap-south-1.elasticbeanstalk.com/api/Users/AddUser"
var URL_USER_DELETE = "http://heimeyapi-dev.ap-south-1.elasticbeanstalk.com/api/Users/DeleteAllUsers"
let URL_USER_RESEND_OTP = "http://heimeyapi-dev.ap-south-1.elasticbeanstalk.com/api/Users/ResndOTP"
let URL_USER_VERIFY_OTP = "http://heimeyapi-dev.ap-south-1.elasticbeanstalk.com/api/Users/VerifyOTP"
var URL_USER_GETMOBILE = "http://heimeyapi-dev.ap-south-1.elasticbeanstalk.com/api/Users/GetUser"
var URL_USER_MY_COURSE = "https://www.bigrockdirtpark.com/api/GetMyCourses"
