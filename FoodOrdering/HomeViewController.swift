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
class HomeViewController: UIViewController {
    var configBGView = UIView()
    var tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        let configBGView = UIView()
        configBGView.backgroundColor = UIColor.white
        self.view.addSubview(configBGView)
        self.configBGView = configBGView
        configBGView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.top.equalTo(self.view)
        }
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "MainScreen")
        self.configBGView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.configBGView)
            make.left.equalTo(self.configBGView)
            make.right.equalTo(self.configBGView)
            make.bottom.equalTo(self.configBGView)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "HOME"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36.0*AutoSizeScaleX)
        configBGView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(configBGView).offset(70*AutoSizeScaleX)
            make.left.right.equalTo(configBGView).offset(20*AutoSizeScaleX)
            make.height.equalTo(40*AutoSizeScaleX)
        }
                let loginBtn = UIButton(type: .custom)
                loginBtn.setTitle("BACK", for: .normal)
                loginBtn.backgroundColor = UIColor.lightGray
                loginBtn.layer.cornerRadius = 20
                loginBtn.titleLabel?.font = .systemFont(ofSize:18*AutoSizeScaleX)
                loginBtn.setTitleColor(UIColor.white, for: .normal)
                loginBtn.contentHorizontalAlignment = .center
                loginBtn.clipsToBounds = true
                loginBtn.addTarget(self, action:#selector(self.loginBtn), for: .touchUpInside)
                self.configBGView.addSubview(loginBtn)
                loginBtn.snp.makeConstraints{(make) -> Void in
                    make.centerX.centerY.equalTo(configBGView)
                    make.height.equalTo(40*AutoSizeScaleX)
                    make.width.equalTo(200*AutoSizeScaleX)
                }
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
                 make.edges.equalTo(self.view)
             }
             self.tableView = tableView
        configureHeaderView()
        // Do any additional setup after loading the view.
    }
    @objc func loginBtn(sender:UIButton!){
    
          let loginVC = LoginViewController()
          self.present(loginVC, animated: true, completion: nil)
    }
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//      let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
//      headerCell.backgroundColor = UIColor.cyanColor()
//
//      switch (section) {
//      case 0:
//        // Do your customization
//        //return sectionHeaderView
//      case 1:
//        // Do your customization
//        //return sectionHeaderView
//      case 2:
//        // Do your customization
//        //return sectionHeaderView
//      default:
//        //return sectionHeaderView
//      }
//
//      return headerCell
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150.0 * AutoSizeScaleX
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let layout = UICollectionViewFlowLayout()
             layout.scrollDirection = .horizontal
             //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

             let headerView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 120), collectionViewLayout: layout)
             headerView.backgroundColor = .blue
             headerView.isPagingEnabled = true
             headerView.isUserInteractionEnabled = true

             headerView.dataSource = self
             headerView.delegate = self
             headerView.register(TemplatesCollectionViewCell.self, forCellWithReuseIdentifier: "weekCollectionViewCellId")
             
             headerView.showsHorizontalScrollIndicator = false

             //tableView.tableHeaderView = headerView
       // let picBookCateDataModel: PicBookCateDataModel = PicBookDataManager.shared.cateArr[section]
//        let header = UIView()
//              switch (section) {
//              case 0:
//                configureHeaderView()
//              case 1:
//            configureHeaderView()
//              case 2:
//                configureHeaderView()
////                let header: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: 60.0 * AutoSizeScaleX))
////                      header.backgroundColor = .blue
////
////                      let lab: UILabel = UILabel()
////                      //lab.text = picBookCateDataModel.cateName
////                      lab.font = .systemFont(ofSize: 20 * AutoSizeScaleX, weight: .bold)
////                      header.addSubview(lab)
////                      lab.snp.makeConstraints { (make) in
////                          make.left.equalTo(header).offset(17.5 * AutoSizeScaleX)
////                          make.centerY.equalTo(header).offset(10 * AutoSizeScaleX)
////                      }
////
////                      let moreBtn: UIButton = UIButton(type: .custom)
////                      moreBtn.tag = section
////                      moreBtn.setTitle("更多", for: .normal)
////                      moreBtn.setTitleColor(.lightGray, for: .normal)
////                    //  moreBtn.setImage(UIImage(named: "general_arrow_orange"), for: .normal)
////                     // moreBtn.imageEdgeInsets = UIEdgeInsets(top: 20 * AutoSizeScaleX, left: IsSmallScreen ? 48 * AutoSizeScaleX : 45 * AutoSizeScaleX, bottom: 0, right: 0)
////                    //  moreBtn.titleEdgeInsets = UIEdgeInsets(top: 20 * AutoSizeScaleX, left: IsSmallScreen ? -28 * AutoSizeScaleX : -25 * AutoSizeScaleX, bottom: 0, right: 0)
////                      moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
////                      moreBtn.addTarget(self, action: #selector(moreBtnAction(sender:)), for: .touchUpInside)
////                      header.addSubview(moreBtn)
////                      moreBtn.snp.makeConstraints { (make) in
////                          make.right.top.bottom.equalTo(header)
////                          make.width.equalTo(80 * AutoSizeScaleX)
////                      }
//              default: break
//                //return sectionHeaderView
//              }
      
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 * AutoSizeScaleX
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "PicBookCellID"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
            cell?.backgroundColor = .orange
            //cell?.delegate = self
        }
        
 
        return cell!
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
        headerView.register(TemplatesCollectionViewCell.self, forCellWithReuseIdentifier: "weekCollectionViewCellId")
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCollectionViewCellId", for: indexPath) as! TemplatesCollectionViewCell
       // let cell: TemplatesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: weekCollectionViewCellId, for: indexPath) as! WeekCollectionViewCell
            cell.contentView.backgroundColor = UIColor.red
        return cell
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
