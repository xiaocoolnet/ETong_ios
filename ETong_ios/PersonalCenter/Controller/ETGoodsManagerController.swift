//
//  ETGoodsManagerController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETGoodsManagerController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate {
    
    @IBOutlet weak var goodsList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentView: UISegmentedControl!
    var goodid = NSString()
    
    
    var shopModel:ETShopModel?
    var helper:ETShopHelper = ETShopHelper()
    var dataSource = NSMutableArray()
    var listType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝贝管理"
        goodsList.registerNib(UINib(nibName: "ETGMSellCell",bundle: nil), forCellReuseIdentifier: "cell1")
//        goodsList.registerNib(UINib(nibName: "ETGMOffShelfCell",bundle: nil), forCellReuseIdentifier: "cell2")
        goodsList.registerNib(UINib(nibName: "ETGMSellCell",bundle: nil), forCellReuseIdentifier: "cell2")
    }
    
    func segAction(seg:UISegmentedControl){
        var index = NSInteger()
        index = seg.selectedSegmentIndex
        switch index {
        case 0:
            seg.selectedSegmentIndex = 0
            getNetData()
        case 1:
            seg.selectedSegmentIndex = 1
            GetNetData()
        default:
            break
        }
    }
    
    override func viewDidAppear(animated: Bool) {

        getNetData()
        self.segmentView.selectedSegmentIndex = 0
        self.segmentView.addTarget(self, action: #selector(self.segAction), forControlEvents: .TouchUpInside)
    }
    
    
    func getNetData(){
        helper.getShopGoodsListWithShopid(shopModel?.id, userid: ETUserInfo.sharedETUserInfo().Id, xiajia: listType == 0 ? nil : "1", success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataSource.removeAllObjects()
            self.dataSource.addObjectsFromArray(models as! [ETGoodsDataModel])
            st_dispatch_async_main({
                self.goodsList.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({ 
                    self.dataSource.removeAllObjects()
                    self.goodsList.reloadData()
                })
        })

    }
    
    func GetNetData(){
        helper.getShopGoodsListWithShopid(shopModel?.id, userid: ETUserInfo.sharedETUserInfo().Id, xiajia: "1", success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataSource.removeAllObjects()
            self.dataSource.addObjectsFromArray(models as! [ETGoodsDataModel])
            st_dispatch_async_main({
                self.goodsList.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({
                    self.dataSource.removeAllObjects()
                    self.goodsList.reloadData()
                })
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    func editGoodsAction(btn:UIButton){
        print(btn.tag)
        let vc = ETEditGoodsController()
        vc.goodModel = dataSource[btn.tag] as? ETGoodsDataModel
        navigationController?.pushViewController(vc, animated: true)
    }
    func soldOutGoodsAction(btn:UIButton){
        self.goodid = (dataSource[btn.tag] as! ETGoodsDataModel).id
        var title = NSString()
        if listType == 0 {
            title = "是否确定要下架"
        }else{
            title = "是否确定要上架"
        }
        let alert = UIAlertController(title: title as String, message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (alertConfirm) -> Void in
            self.SoldOutGoods()
        }
        alert.addAction(alertConfirm)
        let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) -> Void in
        }
        alert.addAction(cancle)
        // 提示框弹出
        presentViewController(alert, animated: true) { () -> Void in
        }
    }
    // 下架、上架商铺产品
    func SoldOutGoods(){
        if self.listType == 0 {
            helper .SoldOutGoodsWithGoodsid(self.goodid as String, success: {[unowned self] (dic) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("下架商品成功")
                    self.getNetData()
                })
            }) { (str, err) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("下架商品失败")
                })
            }
        }else{
            helper.AddedGoodsWithGoodsid(self.goodid as String, success: {[unowned self] (dic) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("上架商品成功")
                    self.GetNetData()
                })
            }) { (str, err) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("上架商品失败")
                })
            }
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        print(buttonIndex)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if listType == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! ETGMSellCell
            cell.showForModel(dataSource[indexPath.row] as! ETGoodsDataModel)
            cell.setViewsTag(indexPath.row)
            cell.editGoods.addTarget(self, action: #selector(editGoodsAction), forControlEvents: .TouchUpInside)
            cell.offSaleBtn.addTarget(self, action: #selector(soldOutGoodsAction), forControlEvents: .TouchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteGoodsAction), forControlEvents: .TouchUpInside)
            cell.selectionStyle = .None
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! ETGMSellCell
            cell.selectionStyle = .None
            cell.offSaleBtn.setTitle("上架", forState: .Normal)
            cell.showForModel(dataSource[indexPath.row] as! ETGoodsDataModel)
            cell.setViewsTag(indexPath.row)
            cell.editGoods.addTarget(self, action: #selector(editGoodsAction), forControlEvents: .TouchUpInside)
            cell.offSaleBtn.addTarget(self, action: #selector(soldOutGoodsAction), forControlEvents: .TouchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteGoodsAction), forControlEvents: .TouchUpInside)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 170
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if listType == 0 {
            let vc = ETGoodsDetailController(nibName: "ETGoodsDetailController", bundle: nil)
            vc.goodModel = dataSource[indexPath.row] as? ETGoodsDataModel
            let model = dataSource[indexPath.row] as? ETGoodsDataModel
            print(vc.goodModel?.price)
            vc.str = 1
            vc.goodsid = (model?.id)!
            vc.shopid = (model?.shopid)!
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func segmentValueChanged(control: UISegmentedControl) {
        listType = control.selectedSegmentIndex
        getNetData()
    }
    // 删除商铺商品
    func deleteGoodsAction(btn:UIButton){
        self.goodid = (dataSource[btn.tag] as! ETGoodsDataModel).id
        let alert = UIAlertController(title: "是否确定要删除该商品", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (alertConfirm) -> Void in
            self.DeleteGoods()
        }
        alert.addAction(alertConfirm)
        let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) -> Void in
        }
        alert.addAction(cancle)
        // 提示框弹出
        presentViewController(alert, animated: true) { () -> Void in
        }

    }
    
    func DeleteGoods(){
        helper.DeleteGoodsWithGoodsid(self.goodid as String, success: {[unowned self] (dic) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("删除商品成功")
                self.getNetData()
                self.GetNetData()
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("删除商品失败")
            })
        }
    }
}
