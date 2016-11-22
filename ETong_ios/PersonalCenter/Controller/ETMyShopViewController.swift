//
//  ETMyShopViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/11/21.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETMyShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    var headView = UIView()
    
    var helper:ETShopHelper = ETShopHelper()
    var model:ETShopModel?
    let imgBtn = UIButton()
    let shopName = UILabel()
    let imgView = UIImageView()
    let collet = UILabel()
    var btn = UIButton()
    var numLab = UILabel()
    
    override func viewWillAppear(animated: Bool) {
        getShopS()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "我的店铺"
        
//        addCollectionView()
    }

    func addCollectionView(){
        //        创建流视图
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 30)/5.0, (self.view.frame.size.width - 30)/5.0 + 50);
        self.collectV = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, self.view.frame.size.height), collectionViewLayout: flowLayout)
        //        注册
        self.collectV?.registerNib(UINib(nibName: "ETMyShopCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "cell")
        //注册头视图
        self.collectV?.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell")
        self.collectV?.delegate = self
        self.collectV?.dataSource = self
        self.collectV?.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectV!)
        flowLayout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 310); //设置collectionView头视图的大小
    }
    
    //    图片的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    //    每行几个
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //    单元格
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:ETMyShopCollectionViewCell  = collectV!.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ETMyShopCollectionViewCell
        cell.backgroundColor = UIColor.whiteColor()
        let titleArr = ["扫一扫","上传宝贝","订单管理","宝贝管理","活动报名","店铺管理","售后管理","评价管理","常见问题","财务结款"]
        let imgArr = ["ic_upload","ic_upload","ic_dingdan","ic_bag","ic_upload","ic_store","ic_shouhou","ic_pingjia-1","ic_question","ic_upload"]
        cell.titleName.text = titleArr[indexPath.item]
        cell.imgView.image = UIImage(named: imgArr[indexPath.item])
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //如果是头视图
        
        let header:UICollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerCell", forIndexPath: indexPath)
        
        headView = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 120))
        headView.backgroundColor = UIColor(red: 253/255, green: 74/255, blue: 75/255, alpha: 1)
        header.addSubview(headView)
        
        addCollectionViewHeader()
        let width = self.view.frame.size.width/3.0
        let arr = ["今日成交总额","几日订单","几日访客"]
        for item in 0...2 {
            btn = UIButton.init(frame: CGRectMake(CGFloat(item)*CGFloat(width), 135, width-1, 80))
            btn.backgroundColor = UIColor.whiteColor()
            btn.tag = 1000+item
            header.addSubview(btn)
            
            numLab = UILabel()
            numLab.frame = CGRectMake(0, 10, width - 1, 40)
            numLab.textColor = UIColor.redColor()
            numLab.font = UIFont.systemFontOfSize(14)
            numLab.textAlignment = .Center
            btn.addSubview(numLab)
            if self.btn.tag == 1000 {
                self.numLab.text = "￥"+(self.model?.ordercount)!
            }else{
                self.numLab.text = "19"
            }
            
            let Lab = UILabel.init(frame: CGRectMake(0, 50, width - 1, 30))
            Lab.textColor = UIColor.lightGrayColor()
            Lab.font = UIFont.systemFontOfSize(15)
            Lab.text = arr[item]
            Lab.textAlignment = .Center
            btn.addSubview(Lab)
        }
        
        let img = UIImageView.init(frame: CGRectMake(0, 230, self.view.frame.size.width, 65))
        img.image = UIImage(named: "ic_guanggao")
        header.addSubview(img)
        
        return header
        
    }
    
    func addCollectionViewHeader(){
        imgBtn.frame = CGRectMake(20, 10, 80, 80)
        headView.addSubview(imgBtn)
        
        shopName.frame = CGRectMake(110, 25, self.view.frame.size.width - 120, 20)
        shopName.font = UIFont.systemFontOfSize(15)
        shopName.textColor = UIColor.whiteColor()
        headView.addSubview(shopName)
        
        imgView.frame = CGRectMake(110, 60, 130, 20)
        headView.addSubview(imgView)
        
        collet.frame = CGRectMake(self.view.frame.size.width - 130, 90, 120, 20)
        collet.textColor = UIColor.whiteColor()
        collet.font = UIFont.systemFontOfSize(14)
        
        collet.textAlignment = .Right
        headView.addSubview(collet)
        
    }

    
    func getShopS(){
        self.helper.getMyShopInfoWithuserid(ETUserInfo.sharedETUserInfo().Id, success: {[unowned self] (dic) in
            st_dispatch_async_main({
                self.addCollectionView()
                self.model = (dic as NSDictionary).objectForKey("goods") as? ETShopModel
                self.imgBtn.sd_setImageWithURL(NSURL(string: kIMAGE_URL_HEAD + (self.model?.photo)!), forState: UIControlState.Normal, placeholderImage: UIImage(named: "ic_xihuan"))
               self.shopName.text = self.model?.shopname
                if (self.model!.level == "0") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_0")
                }else if (self.model!.level == "0.5") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_0_5")
                }else if (self.model?.level == "1") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_1");
                }else if (self.model?.level == "1.5") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_1_5")
                }else if (self.model?.level == "2") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_2")
                }else if (self.model?.level == "2.5") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_2_5")
                }else if (self.model?.level == "3") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_3")
                }else if (self.model?.level == "3.5") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_3_5")
                }else if (self.model?.level == "4") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_4")
                }else if (self.model?.level == "4.5") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_4_5")
                }else if (self.model?.level == "5") {
                    self.imgView.image = UIImage(named: "ic_yellowstar_5")
                }
                self.collet.text = "收藏："+self.model!.businesslicense+"人"

            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("网络错误")
            })
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == 2 {
            let orderManager = ETOrderManagerController()
            navigationController?.pushViewController(orderManager, animated: true)
        }
        if indexPath.item == 1 {
            let vc = ETUploadGoodsController(nibName: "ETUploadGoodsController", bundle: nil)
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.item == 3 {
            let managerVC = ETGoodsManagerController(nibName: "ETGoodsManagerController", bundle: nil)
            managerVC.shopModel = model
            navigationController?.pushViewController(managerVC, animated: true)
        }
        if indexPath.item == 5{
            let vc = ETShopManagerController(nibName: "ETShopManagerController", bundle: nil)
            vc.shopModel = model
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.item == 6 {
            let vc = AfterSaleViewController()
            vc.title = "售后管理"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.item == 7 {
            let vc = AppraiseViewController()
            vc.title = "评价管理"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
