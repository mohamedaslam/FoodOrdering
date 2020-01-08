//
//  MainHomeViewController.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2020/1/6.
//  Copyright © 2020 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import MBProgressHUD

class MainHomeViewController: UIViewController, UISearchBarDelegate {
    var configBGView = UIView()
    var configTopBGView = UIView()
    var configBottomTabBGView = UIView()
    var tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    let searchBar = UISearchBar()
    var arrayTeam = [[String:AnyObject]]() //Array of dictionary
    //var sessionTypeArray:[Any] = []
    var sessionTypeArray : [String] = []

    var arraySession = [[String:AnyObject]]() //Array of dictionary
    
    public var restaurantMainArray: Array = [RestaurantMainDataModel]()
    public var restaurantArray: Array = [RestaurantDataModel]()
    public var categoryArray: Array = [CategoryDataModel]()
    
    public var restaurantMainDataModel: RestaurantMainDataModel?
    public var restaurantDataModel: RestaurantDataModel?
    public var categoryDataModel: CategoryDataModel?

    var foodCourtsCollectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var myfavCollectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var cusineCollectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var brandCollectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
     var otherCollectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let foodCourtCollectionViewCellId = "foodCourtCollectionViewCellId"
    let myFavCollectionViewCellId = "myFavCollectionViewCellId"
    let cusineCollectionViewCellId = "cusineCollectionViewCellId"
    let brandCollectionViewCellId = "brandCollectionViewCellId"
    let otherCollectionViewCellId = "otherCollectionViewId"
     var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configBGView = UIView()
        configBGView.backgroundColor = UIColor.white
        self.view.addSubview(configBGView)
        self.configBGView = configBGView
        configBGView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.top.equalTo(self.view)
        }
        configTopView()
//        let bgImageView = UIImageView()
//        bgImageView.image = UIImage(named: "MainScreen")
//        self.configBGView.addSubview(bgImageView)
//        bgImageView.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(self.configBGView)
//            make.left.equalTo(self.configBGView)
//            make.right.equalTo(self.configBGView)
//            make.bottom.equalTo(self.configBGView)
//        }
//
//        let titleLabel = UILabel()
//        titleLabel.text = "HOME"
//        titleLabel.textColor = UIColor.white
//        titleLabel.textAlignment = .left
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 36.0*AutoSizeScaleX)
//        configBGView.addSubview(titleLabel)
//        titleLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(configBGView).offset(70*AutoSizeScaleX)
//            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
//            make.height.equalTo(40*AutoSizeScaleX)
//        }
//                let loginBtn = UIButton(type: .custom)
//                loginBtn.setTitle("BACK", for: .normal)
//                loginBtn.backgroundColor = UIColor.lightGray
//                loginBtn.layer.cornerRadius = 20
//                loginBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
//                loginBtn.setTitleColor(UIColor.white, for: .normal)
//                loginBtn.contentHorizontalAlignment = .center
//                loginBtn.clipsToBounds = true
//                loginBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
//                self.configBGView.addSubview(loginBtn)
//                loginBtn.snp.makeConstraints{(make) -> Void in
//                    make.centerX.centerY.equalTo(configBGView)
//                    make.height.equalTo(40*AutoSizeScaleX)
//                    make.width.equalTo(200*AutoSizeScaleX)
//                }
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .green
             tableView.separatorStyle = .none
             tableView.dataSource = self
             tableView.delegate = self


             tableView.showsVerticalScrollIndicator = false
             tableView.estimatedRowHeight = 0.0
            // tableView.tableFooterView = UIView()
             self.configBGView.addSubview(tableView)
             tableView.snp.makeConstraints { (make) in
//                 make.edges.equalTo(self.view)
                make.top.equalTo(150*AutoSizeScaleX)
                make.left.equalTo(10*AutoSizeScaleX)
                make.right.equalTo(-10*AutoSizeScaleX)
                make.bottom.equalTo(self.view)
                
             }
             self.tableView = tableView
       configBottomTabBarView()
        getTrackData()
        //configTopView()
        // Do any additional setup after loading the view.
    }
    func configBottomTabBarView(){
        let configBottomTabBGView = UIView()
        configBottomTabBGView.backgroundColor = UIColor.red
        configBottomTabBGView.layer.cornerRadius = 35;
        configBottomTabBGView.layer.masksToBounds = true;
        self.configBGView.addSubview(configBottomTabBGView)
                      //self.configTopBGView = configTopBGView
            configBottomTabBGView.snp.makeConstraints { (make) -> Void in
                make.left.equalTo(self.configBGView).offset(30*AutoSizeScaleX)
                make.right.equalTo(self.configBGView).offset(-30*AutoSizeScaleX)
            make.bottom.equalTo(-20*AutoSizeScaleX)
            make.height.equalTo(70*AutoSizeScaleX)
        }
        self.configBottomTabBGView = configBottomTabBGView
        
        let homeBtn = UIButton(type: .custom)
               homeBtn.backgroundColor = UIColor.lightGray
               homeBtn.layer.cornerRadius = 20
               homeBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
               homeBtn.setTitleColor(UIColor.white, for: .normal)
               homeBtn.contentHorizontalAlignment = .center
               homeBtn.clipsToBounds = true
               homeBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
               self.configTopBGView.addSubview(homeBtn)
               homeBtn.snp.makeConstraints{(make) -> Void in
                make.width.height.equalTo(30*AutoSizeScaleX)
               }
        
        
        let addRecipeBtn = UIButton(type: .custom)
               addRecipeBtn.backgroundColor = UIColor.lightGray
               addRecipeBtn.layer.cornerRadius = 20
               addRecipeBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
               addRecipeBtn.setTitleColor(UIColor.white, for: .normal)
               addRecipeBtn.contentHorizontalAlignment = .center
               addRecipeBtn.clipsToBounds = true
               addRecipeBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
               self.configTopBGView.addSubview(addRecipeBtn)
               addRecipeBtn.snp.makeConstraints{(make) -> Void in
                make.left.top.equalTo(self.configBottomTabBGView)
                   make.width.height.equalTo(30*AutoSizeScaleX)
               }
        
        
        let tableBookBtn = UIButton(type: .custom)
               tableBookBtn.backgroundColor = UIColor.lightGray
               tableBookBtn.layer.cornerRadius = 20
               tableBookBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
               tableBookBtn.setTitleColor(UIColor.white, for: .normal)
               tableBookBtn.contentHorizontalAlignment = .center
               tableBookBtn.clipsToBounds = true
               tableBookBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
               self.configTopBGView.addSubview(tableBookBtn)
               tableBookBtn.snp.makeConstraints{(make) -> Void in
                make.top.equalTo(self.configBottomTabBGView)
                make.left.equalTo(addRecipeBtn)
                   make.width.height.equalTo(20*AutoSizeScaleX)
               }
        
        let cartBtn = UIButton(type: .custom)
               cartBtn.backgroundColor = UIColor.lightGray
               cartBtn.layer.cornerRadius = 20
               cartBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
               cartBtn.setTitleColor(UIColor.white, for: .normal)
               cartBtn.contentHorizontalAlignment = .center
               cartBtn.clipsToBounds = true
               cartBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
               self.configTopBGView.addSubview(cartBtn)
               cartBtn.snp.makeConstraints{(make) -> Void in
               make.top.equalTo(self.configBottomTabBGView)
                make.right.equalTo(self.configBottomTabBGView)
                   make.width.height.equalTo(20*AutoSizeScaleX)
               }
        let stackView = UIStackView(arrangedSubviews: [homeBtn,addRecipeBtn,tableBookBtn,cartBtn])
               stackView.axis = .horizontal
        stackView.distribution = .fillEqually
               self.configBottomTabBGView.addSubview(stackView)
               stackView.snp.makeConstraints{(make) -> Void in
                   make.top.bottom.left.right.equalTo(self.configBottomTabBGView)
               }
    }
    func configTopView(){
        let configTopBGView = UIView()
               configTopBGView.backgroundColor = UIColor.white
        self.configBGView.addSubview(configTopBGView)
               //self.configTopBGView = configTopBGView
               configTopBGView.snp.makeConstraints { (make) -> Void in
                make.left.right.equalTo(self.configBGView)
                make.top.equalTo(10*AutoSizeScaleX)
                make.height.equalTo(130*AutoSizeScaleX)
               }
        self.configTopBGView = configTopBGView
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "samosas")
        self.configTopBGView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configTopBGView.snp.top).offset(20*AutoSizeScaleX)
            make.left.equalTo(self.configTopBGView).offset(10*AutoSizeScaleX)
            make.width.equalTo(100*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "samosas")
        self.configTopBGView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configTopBGView.snp.top).offset(20*AutoSizeScaleX)
            make.right.equalTo(self.configTopBGView).offset(-10*AutoSizeScaleX)
            make.width.equalTo(50*AutoSizeScaleX)
            make.height.equalTo(50*AutoSizeScaleX)
        }
        let mainCityNameLabel = UILabel()
        mainCityNameLabel.text = "Bangalore"
        mainCityNameLabel.textColor = UIColor.black
        mainCityNameLabel.textAlignment = .left
        mainCityNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0*AutoSizeScaleX)
        self.configTopBGView.addSubview(mainCityNameLabel)
        mainCityNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(logoImageView)
            make.centerX.equalTo(self.configTopBGView).offset(50*AutoSizeScaleX)
            make.width.equalTo(120*AutoSizeScaleX)
            make.height.equalTo(20*AutoSizeScaleX)
        }
        let areaNameLabel = UILabel()
        areaNameLabel.text = "White field ITPL"
        areaNameLabel.textColor = UIColor.black
        areaNameLabel.textAlignment = .left
        areaNameLabel.font = UIFont.boldSystemFont(ofSize: 12.0*AutoSizeScaleX)
        self.configTopBGView.addSubview(areaNameLabel)
        areaNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mainCityNameLabel.snp.bottom).offset(4*AutoSizeScaleX)
            make.left.width.height.equalTo(mainCityNameLabel)
        }
        let locationBtn = UIButton(type: .custom)
        locationBtn.backgroundColor = UIColor.lightGray
        locationBtn.layer.cornerRadius = 20
        locationBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        locationBtn.setTitleColor(UIColor.white, for: .normal)
        locationBtn.contentHorizontalAlignment = .center
        locationBtn.clipsToBounds = true
        locationBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
        self.configTopBGView.addSubview(locationBtn)
        locationBtn.snp.makeConstraints{(make) -> Void in
            make.right.equalTo(mainCityNameLabel.snp.left).offset(-4*AutoSizeScaleX)
            make.top.height.equalTo(logoImageView)
            make.width.equalTo(50*AutoSizeScaleX)
         }
        
        let scanBtn = UIButton(type: .custom)
        scanBtn.backgroundColor = UIColor.lightGray
        scanBtn.layer.cornerRadius = 20
        scanBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        scanBtn.setTitleColor(UIColor.white, for: .normal)
        scanBtn.contentHorizontalAlignment = .center
        scanBtn.clipsToBounds = true
        scanBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
        self.configTopBGView.addSubview(scanBtn)
        scanBtn.snp.makeConstraints{(make) -> Void in
            make.right.equalTo(profileImageView.snp.right)
            make.top.equalTo(locationBtn.snp.bottom).offset(12*AutoSizeScaleX)
            make.width.height.equalTo(36*AutoSizeScaleX)
        }
        
        let filterBtn = UIButton(type: .custom)
        filterBtn.backgroundColor = UIColor.lightGray
        filterBtn.layer.cornerRadius = 20
        filterBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
        filterBtn.setTitleColor(UIColor.white, for: .normal)
        filterBtn.contentHorizontalAlignment = .center
        filterBtn.clipsToBounds = true
        filterBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
        self.configTopBGView.addSubview(filterBtn)
        filterBtn.snp.makeConstraints{(make) -> Void in
            make.right.equalTo(scanBtn.snp.left).offset(-8*AutoSizeScaleX)
            make.top.equalTo(scanBtn)
            make.height.equalTo(36*AutoSizeScaleX)
            make.width.equalTo(80*AutoSizeScaleX)
        }
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = "Search for Restaurant"
        searchBar.tintColor = UIColor(red:0.73, green:0.76, blue:0.78, alpha:1.0)
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        //1. Lighter background color
        searchBar.barTintColor = .white

        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(logoImageView)
            make.right.equalTo(filterBtn.snp.left)
            make.height.equalTo(34*AutoSizeScaleX)
            make.top.equalTo(scanBtn.snp.top)
        }
        
    }
    @objc func loginBtn(sender:UIButton!){
    
          let loginVC = LoginViewController()
          self.present(loginVC, animated: true, completion: nil)
    }
     override func viewDidAppear(_ animated: Bool) {
            for subView in searchBar.subviews  {
                for subsubView in subView.subviews  {
                    if let textField = subsubView as? UITextField {
                        var bounds: CGRect
                        bounds = textField.frame

                        //2. Shorter textfield in height
                        bounds.size.height = 28
                        textField.bounds = bounds

                        //3. Textfield to have less corner radious
                        textField.layer.cornerRadius = 5 //Probably you can play with this and see the changes.
                        textField.clipsToBounds = true
                    }
                }
            }
        }
    
    func getTrackData(){
           let keychain = KeychainSwift()
           var getaccessToken = String()
           if let value = keychain.get("Token") {
               getaccessToken = value
           }
           let headers = [
               "Authorization": "bearer " + getaccessToken,
               "Accept": "application/json"
           ]
           Alamofire.request(URL_GET_RESTAURANTS, method: .get,encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
              // debugPrint(response)
             //  print("dfafTRACKresponse")
               
               switch response.result {
               case .success:
                 print(response)
                  // print("TRACKresponse")
                   
                   if let result = response.result.value{
                       let swiftyJsonVar = JSON(result)
                    if swiftyJsonVar["status"].bool != nil{
                         print("SUCESSSS")
                         var categoryModelArr: [CategoryDataModel] = [CategoryDataModel]()
                         var restuarantInfoModelArr: [RestaurantDataModel] = [RestaurantDataModel]()
                        for restaurantInfo in swiftyJsonVar["restaurantHomescreen"].arrayValue
                           {
                            for categoriesInfo in restaurantInfo["categories"].arrayValue
                            {
                                 print(categoriesInfo)
                                 print("categoriesInfo")
                                let categoryDataModel = CategoryDataModel(categoryID: categoriesInfo["categoryID"].string!, categoryName: categoriesInfo["categoryImage"].string!, categoryImage: categoriesInfo["categoryName"].string!)
                                categoryModelArr.append(categoryDataModel)

                            }
                           // if  let restaurantArrayInfo = restaurantInfo["restaurants"].arrayObject
                            for restaurantArrayInfo in restaurantInfo["restaurants"].arrayValue
                            {
                                print(restaurantArrayInfo["restaurantID"].string!)
                                print("restaurantArrayInfo")
                                let restaurantDataModel = RestaurantDataModel.init(restaurantID: restaurantArrayInfo["restaurantID"].string!, restaurantName: restaurantArrayInfo["restaurantID"].string!, restaurantImage: restaurantArrayInfo["restaurantID"].string!, restaurantRatings: restaurantArrayInfo["restaurantID"].string!, restaurantTime: restaurantArrayInfo["restaurantID"].string!, currentStatus: restaurantArrayInfo["restaurantID"].string!, promotion: restaurantArrayInfo["restaurantID"].string!, isUserfavorites: restaurantArrayInfo["restaurantID"].bool!)
                             //   let model: PicBookCateDataModel = PicBookCateDataModel.init(cateId: dic["cateId"]?.int, cateName: dic["cateName"]?.string, cateIcon: dic["cateIcon"]?.string, updateTime: dic["updateTime"]?.int, bookCount: dic["bookCount"]?.int, books: bookModelArr)
                              restuarantInfoModelArr.append(restaurantDataModel)
                            }
                               // self.sessionTypeArray.append(sessionTypeStr)
                                print("sessionTypesessionType")
                                //self.restaurantMainDataModel = RestaurantMainDataModel(sessionType: restaurantInfo["sessionType"].string, sessionName: restaurantInfo["sessionType"].string, promotions: restaurantInfo["sessionType"].string, categories:nil , restaurants:nil )
                               
                           
                        }
                        if self.sessionTypeArray.count > 0 {
                          self.tableView.reloadData()
                             }
                         print(self.sessionTypeArray)
                         print("self.sessionTypeArray")
//                        if let resData = swiftyJsonVar["restaurantHomescreen"].arrayObject
//                        {
//                            print(resData)
//                            print("RESDATAAA")
//
//                            if let sessionType = resData["sessionType"]!.string{
//                          //  print(sessionType)
//                            print("RESDATAAA1")
//                            self.arrayTeam = resData as! [[String:AnyObject]]
//                           }
//                              //  self.arrayTeam = resData as! [[String:AnyObject]]
//                        }
                       }
                       
                   }
               case .failure(let error):
                   print("FAILURE")
                   print(response.response!)
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
                           return
                       }
                   } else {
                       message = error.localizedDescription
                       print(message)
                       print("messagemessage DEhttpStatusCode")
                   }
               }
               MBProgressHUD.hide(for: self.view, animated: true)
           }
        print(self.sessionTypeArray)
        print("ARRAY TEAMMM")
       }
    
    }
extension MainHomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sessionTypeArray.count
    }
    

  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 * AutoSizeScaleX
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(self.sessionTypeArray[indexPath.row])
               print("ARRAy")
        if (self.sessionTypeArray[indexPath.row] == "FCCateory"){
      //  if (indexPath.row == 0){
        // let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryTableViewCell
            let cellID = "CategoryCollectionViewCell"
                       var cell: CategoryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? CategoryTableViewCell
                       if cell == nil {
                           cell = CategoryTableViewCell(style: .default, reuseIdentifier: cellID)
                           cell?.selectionStyle = .none
                           cell?.backgroundColor = .green
                           //cell?.delegate = self
                       }
            return cell!
        }
        if (self.sessionTypeArray[indexPath.row] == "FCUserFavorites"){
               // let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryTableViewCell
                   let cellID = "CategoryCollectionViewCell"
                              var cell: CategoryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? CategoryTableViewCell
                              if cell == nil {
                                  cell = CategoryTableViewCell(style: .default, reuseIdentifier: cellID)
                                  cell?.selectionStyle = .none
                                  cell?.backgroundColor = .green
                                  //cell?.delegate = self
                              }
                   return cell!
               }
        else{

            let cellID = "PicBookCellID"
            var cell: RestaurantsDetailsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? RestaurantsDetailsTableViewCell
            if cell == nil {
                cell = RestaurantsDetailsTableViewCell(style: .default, reuseIdentifier: cellID)
                cell?.selectionStyle = .none
                cell?.backgroundColor = .orange
                //cell?.delegate = self
            }
            return cell!
        }
        }
    
    @objc func moreBtnAction(sender: UIButton) {
        
    }
}
