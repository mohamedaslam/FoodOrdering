//
//  HomeViewController.swift
//  FoodOrdering
//
//  Created by Aslam on 2019/11/24.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit
let collectionItemWidth: CGFloat = (SCREEN_WIDTH - 35 * AutoSizeScaleX - 20 * AutoSizeScaleX) / 3
let collectionItemHeight: CGFloat = collectionItemWidth + 30 * AutoSizeScaleX
class HomeViewController: UIViewController, UISearchBarDelegate {
    var configBGView = UIView()
    var configTopBGView = UIView()
    var configBottomTabBGView = UIView()
    var tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
    let searchBar = UISearchBar()
    
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
    }


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 5
        case 1:
            return 2
        default:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
             return 260.0 * AutoSizeScaleX
        case 1:
            return 260.0 * AutoSizeScaleX
        case 2:
            return 240.0 * AutoSizeScaleX
        default:
            return 250.0 * AutoSizeScaleX
        }
       
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header: UIView = UIView(frame: CGRect(x: 10.0*AutoSizeScaleX, y: 0.0, width: SCREEN_WIDTH-20*AutoSizeScaleX, height: 200 * AutoSizeScaleX))
        header.backgroundColor = newWhiteSmokeColor
               
               switch (section) {
              case 0:

                let titleLabel: UILabel = UILabel()
               titleLabel.text = "Food Courts"
               titleLabel.textColor = UIColor.black
               titleLabel.font = UIFont.systemFont(ofSize: 20 * AutoSizeScaleX)
               header.addSubview(titleLabel)
               titleLabel.snp.makeConstraints { (make) in
                   make.top.equalTo(header.snp.top).offset(4*AutoSizeScaleX)
                   make.left.right.equalTo(header)
                   make.height.equalTo(16*AutoSizeScaleX)
               }
              let subtitleLabel: UILabel = UILabel()
              subtitleLabel.text = "Always feeded you at its best quality"
              subtitleLabel.textColor = UIColor.darkGray
              subtitleLabel.font = UIFont.systemFont(ofSize: 12 * AutoSizeScaleX)
              header.addSubview(subtitleLabel)
              subtitleLabel.snp.makeConstraints { (make) in
                  make.top.equalTo(titleLabel.snp.bottom).offset(4*AutoSizeScaleX)
                  make.left.right.equalTo(header)
                  make.height.equalTo(16*AutoSizeScaleX)
              }
              let moreBtn: UIButton = UIButton(type: .custom)
              moreBtn.tag = section
              moreBtn.setTitle("See all", for: .normal)
              moreBtn.setTitleColor(.red, for: .normal)
             // moreBtn.setImage(UIImage(named: "general_arrow_orange"), for: .normal)
              moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
              moreBtn.addTarget(self, action: #selector(moreBtnAction(sender:)), for: .touchUpInside)
              header.addSubview(moreBtn)
              moreBtn.snp.makeConstraints { (make) in
                  make.right.equalTo(header)
                  make.top.equalTo(4*AutoSizeScaleX)
                 make.height.equalTo(20*AutoSizeScaleX)
                  make.width.equalTo(60 * AutoSizeScaleX)
              }
              /////////
            let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
                              //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
           let headerView = UICollectionView(frame: CGRect(x: 4, y: 40, width: view.frame.width, height: 200), collectionViewLayout: layout)
           headerView.backgroundColor = .red
           headerView.isPagingEnabled = true
           headerView.isUserInteractionEnabled = true
           headerView.dataSource = self
           headerView.delegate = self
           headerView.showsHorizontalScrollIndicator = false
           header.addSubview(headerView)
                self.foodCourtsCollectionView = headerView
           headerView.register(FoodCourtCollectionViewCell.self, forCellWithReuseIdentifier: "foodCourtCollectionViewCellId")
              
            let recommendedRestaurantsLabel: UILabel = UILabel()
               recommendedRestaurantsLabel.text = "Recommended Restaurants"
               recommendedRestaurantsLabel.textColor = UIColor.black
               recommendedRestaurantsLabel.font = UIFont.boldSystemFont(ofSize: 18*AutoSizeScaleX)
               header.addSubview(recommendedRestaurantsLabel)
               recommendedRestaurantsLabel.snp.makeConstraints { (make) in
                    make.top.equalTo(headerView.snp.bottom)
                    make.left.right.equalTo(header)
                    make.height.equalTo(20*AutoSizeScaleX)
            }
             
       return header
         case 1:
            let titleLabel: UILabel = UILabel()
                          titleLabel.text = "My Favourite Recipie"
                          titleLabel.textColor = UIColor.black
                          titleLabel.font = UIFont.systemFont(ofSize: 20 * AutoSizeScaleX)
                          header.addSubview(titleLabel)
                          titleLabel.snp.makeConstraints { (make) in
                              make.top.equalTo(header.snp.top).offset(4*AutoSizeScaleX)
                              make.left.right.equalTo(header)
                              make.height.equalTo(16*AutoSizeScaleX)
                          }
                         let subtitleLabel: UILabel = UILabel()
                         subtitleLabel.text = "You loved eating this always"
                         subtitleLabel.textColor = UIColor.darkGray
                         subtitleLabel.font = UIFont.systemFont(ofSize: 12 * AutoSizeScaleX)
                         header.addSubview(subtitleLabel)
                         subtitleLabel.snp.makeConstraints { (make) in
                             make.top.equalTo(titleLabel.snp.bottom).offset(2*AutoSizeScaleX)
                             make.left.right.equalTo(header)
                             make.height.equalTo(16*AutoSizeScaleX)
                         }
                         let moreBtn: UIButton = UIButton(type: .custom)
                         moreBtn.tag = section
                         moreBtn.setTitle("See all", for: .normal)
                         moreBtn.setTitleColor(.red, for: .normal)
                        // moreBtn.setImage(UIImage(named: "general_arrow_orange"), for: .normal)
                         moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                         moreBtn.addTarget(self, action: #selector(moreBtnAction(sender:)), for: .touchUpInside)
                         header.addSubview(moreBtn)
                         moreBtn.snp.makeConstraints { (make) in
                            make.right.equalTo(header)
                             make.top.equalTo(4*AutoSizeScaleX)
                            make.height.equalTo(20*AutoSizeScaleX)
                             make.width.equalTo(60 * AutoSizeScaleX)
                         }
                         /////////
                       let layout = UICollectionViewFlowLayout()
                      layout.scrollDirection = .horizontal
                                         //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                  
                      let headerView = UICollectionView(frame: CGRect(x: 4, y: 40, width: view.frame.width, height: 200), collectionViewLayout: layout)
                      headerView.backgroundColor = .white
                      headerView.isPagingEnabled = true
                      headerView.isUserInteractionEnabled = true
                      headerView.dataSource = self
                      headerView.delegate = self
                      headerView.showsHorizontalScrollIndicator = false
                      header.addSubview(headerView)
                      headerView.register(MyFavCollectionViewCell.self, forCellWithReuseIdentifier: "myFavCollectionViewCellId")
            self.myfavCollectionView = headerView
                        let recommendedRestaurantsLabel: UILabel = UILabel()
                                    recommendedRestaurantsLabel.text = "Recommended Restaurants"
                                    recommendedRestaurantsLabel.textColor = UIColor.black
            recommendedRestaurantsLabel.font = UIFont.boldSystemFont(ofSize: 18*AutoSizeScaleX)
                                    header.addSubview(recommendedRestaurantsLabel)
                                    recommendedRestaurantsLabel.snp.makeConstraints { (make) in
                                         make.top.equalTo(headerView.snp.bottom)
                                         make.left.right.equalTo(header)
                                         make.height.equalTo(20*AutoSizeScaleX)
                                 }
                  return header


              case 2:
            let titleLabel: UILabel = UILabel()
                          titleLabel.text = "Cuisines For You"
                          titleLabel.textColor = UIColor.black
                          titleLabel.font = UIFont.systemFont(ofSize: 20 * AutoSizeScaleX)
                          header.addSubview(titleLabel)
                          titleLabel.snp.makeConstraints { (make) in
                              make.top.equalTo(header.snp.top).offset(4*AutoSizeScaleX)
                              make.left.right.equalTo(header)
                              make.height.equalTo(16*AutoSizeScaleX)
                          }
                         let subtitleLabel: UILabel = UILabel()
                         subtitleLabel.text = "Most preffered meals in your location"
                         subtitleLabel.textColor = UIColor.darkGray
                         subtitleLabel.font = UIFont.systemFont(ofSize: 12 * AutoSizeScaleX)
                         header.addSubview(subtitleLabel)
                         subtitleLabel.snp.makeConstraints { (make) in
                             make.top.equalTo(titleLabel.snp.bottom).offset(2*AutoSizeScaleX)
                             make.left.right.equalTo(header)
                             make.height.equalTo(16*AutoSizeScaleX)
                         }
                         let moreBtn: UIButton = UIButton(type: .custom)
                         moreBtn.tag = section
                         moreBtn.setTitle("See all", for: .normal)
                         moreBtn.setTitleColor(.red, for: .normal)
                        // moreBtn.setImage(UIImage(named: "general_arrow_orange"), for: .normal)
                         moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                         moreBtn.addTarget(self, action: #selector(moreBtnAction(sender:)), for: .touchUpInside)
                         header.addSubview(moreBtn)
                         moreBtn.snp.makeConstraints { (make) in
                             make.right.equalTo(header)
                            make.top.equalTo(4*AutoSizeScaleX)
                            make.height.equalTo(20*AutoSizeScaleX)
                             make.width.equalTo(60 * AutoSizeScaleX)
                         }
                         /////////
                       let layout = UICollectionViewFlowLayout()
                      layout.scrollDirection = .horizontal
                                         //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                  
                      let headerView = UICollectionView(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 130), collectionViewLayout: layout)
                      headerView.backgroundColor = .white
                      headerView.isPagingEnabled = true
                      headerView.isUserInteractionEnabled = true
                      headerView.dataSource = self
                      headerView.delegate = self
                      headerView.showsHorizontalScrollIndicator = false
                      header.addSubview(headerView)
                      headerView.register(CusineCollectionViewCell.self, forCellWithReuseIdentifier: "cusineCollectionViewCellId")
            self.cusineCollectionView = headerView
                        let recommendedRestaurantsLabel: UILabel = UILabel()
                                    recommendedRestaurantsLabel.text = "Recommended Restaurants"
                                    recommendedRestaurantsLabel.textColor = UIColor.black
                                    recommendedRestaurantsLabel.font = UIFont.boldSystemFont(ofSize: 18*AutoSizeScaleX)
                                    header.addSubview(recommendedRestaurantsLabel)
                                    recommendedRestaurantsLabel.snp.makeConstraints { (make) in
                                         make.top.equalTo(headerView.snp.bottom)
                                         make.left.right.equalTo(header)
                                         make.height.equalTo(20*AutoSizeScaleX)
                                 }
                  return header
               case 3:
                let titleLabel: UILabel = UILabel()
                                         titleLabel.text = "Brand you would love"
                                         titleLabel.textColor = UIColor.black
                                         titleLabel.font = UIFont.systemFont(ofSize: 20 * AutoSizeScaleX)
                                         header.addSubview(titleLabel)
                                         titleLabel.snp.makeConstraints { (make) in
                                             make.top.equalTo(header.snp.top).offset(4*AutoSizeScaleX)
                                             make.left.right.equalTo(header)
                                             make.height.equalTo(16*AutoSizeScaleX)
                                         }
                                       
                                        let moreBtn: UIButton = UIButton(type: .custom)
                                        moreBtn.tag = section
                                        moreBtn.setTitle("See all", for: .normal)
                                        moreBtn.setTitleColor(.red, for: .normal)
                                       // moreBtn.setImage(UIImage(named: "general_arrow_orange"), for: .normal)
                                        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                                        moreBtn.addTarget(self, action: #selector(moreBtnAction(sender:)), for: .touchUpInside)
                                        header.addSubview(moreBtn)
                                        moreBtn.snp.makeConstraints { (make) in
                                            make.right.equalTo(header)
                                           make.top.equalTo(4*AutoSizeScaleX)
                                           make.height.equalTo(20*AutoSizeScaleX)
                                            make.width.equalTo(60 * AutoSizeScaleX)
                                        }
                                        /////////
                                      let layout = UICollectionViewFlowLayout()
                                     layout.scrollDirection = .horizontal
                                                        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                                 
                                     let headerView = UICollectionView(frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 160), collectionViewLayout: layout)
                                     headerView.backgroundColor = .white
                                     headerView.isPagingEnabled = true
                                     headerView.isUserInteractionEnabled = true
                                     headerView.dataSource = self
                                     headerView.delegate = self
                                     headerView.showsHorizontalScrollIndicator = false
                                     header.addSubview(headerView)
                                     headerView.register(BrandsCollectionViewCell.self, forCellWithReuseIdentifier: "brandCollectionViewCellId")
                           self.brandCollectionView = headerView
                                       let recommendedRestaurantsLabel: UILabel = UILabel()
                                                   recommendedRestaurantsLabel.text = "Recommended Restaurants"
                                                   recommendedRestaurantsLabel.textColor = UIColor.black
                                                   recommendedRestaurantsLabel.font = UIFont.boldSystemFont(ofSize: 18*AutoSizeScaleX)
                                                   header.addSubview(recommendedRestaurantsLabel)
                                                   recommendedRestaurantsLabel.snp.makeConstraints { (make) in
                                                        make.top.equalTo(headerView.snp.bottom)
                                                        make.left.right.equalTo(header)
                                                        make.height.equalTo(20*AutoSizeScaleX)
                                                }
                                 return header
         default: break
              }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 * AutoSizeScaleX
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
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
        }else{

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
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configureHeaderView() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let headerView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150), collectionViewLayout: layout)
        headerView.backgroundColor = .blue
        headerView.isPagingEnabled = true
        headerView.isUserInteractionEnabled = true

        headerView.dataSource = self
        headerView.delegate = self
       // headerView.register(TemplatesCollectionViewCell.self, forCellWithReuseIdentifier: "weekCollectionViewCellId")
        
        headerView.showsHorizontalScrollIndicator = false

        tableView.tableHeaderView = headerView
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodCourtsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCourtCollectionViewCellId", for: indexPath) as! FoodCourtCollectionViewCell
                cell.contentView.backgroundColor = newWhiteSmokeColor
            return cell
        }
        if collectionView == self.myfavCollectionView{
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myFavCollectionViewCellId", for: indexPath) as! MyFavCollectionViewCell
            return cell 
        }
        if collectionView == self.cusineCollectionView{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cusineCollectionViewCellId", for: indexPath) as! CusineCollectionViewCell
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCollectionViewCellId", for: indexPath) as! BrandsCollectionViewCell
            return cell
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.foodCourtsCollectionView {
                   return CGSize(width: 140, height: 190)
        } else if collectionView == self.myfavCollectionView {
                   return CGSize(width: 140, height: 190)
        } else if collectionView == self.cusineCollectionView{
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
       }
}
extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: Int = 255) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }

    convenience init(netHex:Int) {
        self.init(r:(netHex >> 16) & 0xff, g:(netHex >> 8) & 0xff, b:netHex & 0xff)
    }
}
