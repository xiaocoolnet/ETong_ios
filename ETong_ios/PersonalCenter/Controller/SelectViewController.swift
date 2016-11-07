//
//  SelectViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    var goodModel:AttributesModel?
    var goodid:NSString?
    var collectV:UICollectionView?
    var flowLayout = UICollectionViewFlowLayout()
    var dataArray = NSMutableArray()
    var helper:ETShopHelper = ETShopHelper()
    var type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "选择规格"
        
        let btn = UIButton()
        btn.frame = CGRectMake(10, self.view.frame.size.height - 200, self.view.frame.size.width - 20, 50)
        btn.setTitle("立即上传", forState: .Normal)
        btn.addTarget(self, action: #selector(self.clickSureBtn), forControlEvents: .TouchUpInside)
        btn.backgroundColor = UIColor(red: 253/255, green: 74/255, blue: 75/255, alpha: 1)
        self.view.addSubview(btn)
        
        addCollectionView()
    }
    
    func addCollectionView(){
        //        创建流视图
        
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 20)/3.0, 40);
        self.collectV = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, self.view.frame.size.height - 220), collectionViewLayout: flowLayout)
        //        注册
        self.collectV?.registerClass(SelectCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectV?.delegate = self
        self.collectV?.dataSource = self
        self.collectV?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(collectV!)
    }

    //    图片的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.goodModel?.plist.count)!
    }
    //    每行几个
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //    单元格
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:SelectCollectionViewCell  = collectV!.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! SelectCollectionViewCell
        let arr = self.goodModel?.plist[indexPath.row] as! propertyList
        
        cell.btn.frame = cell.contentView.frame
        cell.btn.backgroundColor = UIColor.whiteColor()
        cell.btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cell.btn.setTitle(arr.name, forState: .Normal)
        cell.btn.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        cell.btn.selected = false
        cell.btn.tag = indexPath.item
        cell.btn.addTarget(self, action: #selector(self.ClickSelectBtn), forControlEvents: .TouchUpInside)
        cell.contentView.addSubview(cell.btn)
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    func ClickSelectBtn(sender:UIButton){
        sender.selected = !sender.selected
        let arr = self.goodModel?.plist[sender.tag] as! propertyList
        let strId = arr.id
        if sender.selected == true {
            sender.backgroundColor = UIColor(red: 253/255, green: 74/255, blue: 75/255, alpha: 1)
           self.dataArray.addObject(strId)
        }else{
            sender.backgroundColor = UIColor.whiteColor()
            self.dataArray.removeObject(strId)
        }
        print(self.dataArray);
    }
    
    func clickSureBtn(){
        if self.dataArray.count == 0 {
            SVProgressHUD.showSuccessWithStatus("请选择规格")
            return
        }
        let propertylist = self.dataArray.componentsJoinedByString(",")
        print(propertylist)
        helper.AddGoodsAttributesInfoWithGoodsid(self.goodid as! String, type: self.type, propertylist: propertylist, success: {[unowned self] (dic) in
            st_dispatch_async_main({
                
                SVProgressHUD.showSuccessWithStatus("修改成功")
                self.navigationController?.popViewControllerAnimated(true)
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("修改失败")
            })
        }
    }
}
