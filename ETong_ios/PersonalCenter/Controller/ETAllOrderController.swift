//
//  ETAllOrderController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETAllOrderController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var orderList: UITableView!
    var shopModel:OrderListModel?
    var helper:ETShopHelper = ETShopHelper()
    var dataArray = NSMutableArray()
    
    override func viewWillAppear(animated: Bool) {
        GetShopOrderList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        orderList.registerNib(UINib(nibName: "ETAllOrderCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    func GetShopOrderList(){
        helper.GetMyShopOrderListInfoWithShopid(ETUserInfo.sharedETUserInfo().shopid, success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(models as! [OrderListModel])
            st_dispatch_async_main({
                self.orderList.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({
                    self.dataArray.removeAllObjects()
                    self.orderList.reloadData()
                })
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! ETAllOrderCell
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        let model = dataArray[indexPath.row] as! OrderListModel
        cell.goodsName.text = model.goodsname
        cell.goodsNumber.text = "X" + model.number
        cell.goodsPrice.text = "￥" + model.money
        let strArray = model.picture.componentsSeparatedByString(",")
        let str = kIMAGE_URL_HEAD + strArray.first!
        let photourl = NSURL(string: str)
        cell.imgView.sd_setImageWithURL(photourl, placeholderImage: UIImage(named: "ic_xihuan"))
        if model.states == "1" {
            cell.stateLab.setTitle("未付款", forState: .Normal)
            cell.bottomBtn.setTitle("等待付款", forState: .Normal)
        }else if model.states == "2"{
            cell.stateLab.setTitle("待发货", forState: .Normal)
            cell.bottomBtn.setTitle("马上发货", forState: .Normal)
        }else if model.states == "3"{
            cell.stateLab.setTitle("待签收", forState: .Normal)
            cell.bottomBtn.setTitle("实时追踪", forState: .Normal)
        }else if model.states == "4"{
            cell.stateLab.setTitle("已完成", forState: .Normal)
            cell.bottomBtn.setTitle("评价", forState: .Normal)
        }else if model.states == "5"{
            cell.stateLab.setTitle("已完成", forState: .Normal)
            cell.bottomBtn.setTitle("已评价", forState: .Normal)
        }else{
            cell.stateLab.setTitle("已取消", forState: .Normal)
            cell.bottomBtn.setTitle("已取消", forState: .Normal)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 230
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = OrderDetailsViewController()
        vc.hidesBottomBarWhenPushed = true
        let model = dataArray[indexPath.row] as! OrderListModel
        vc.dataSource = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}