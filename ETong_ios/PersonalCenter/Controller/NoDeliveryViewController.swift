//
//  NoDeliveryViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class NoDeliveryViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
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
        AddTableView()
    }
    
    func GetShopOrderList(){
        helper.GetMyShopOrderListInfoWithShopid(ETUserInfo.sharedETUserInfo().shopid, state:
            "2", success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(models as! [OrderListModel])
            st_dispatch_async_main({
                self.tableView.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({
                    self.dataArray.removeAllObjects()
                    self.tableView.reloadData()
                })
        })
    }

    func AddTableView(){
        tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 44)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerNib(UINib(nibName: "ETAllOrderCell",bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
        cell.stateLab.setTitle("待发货", forState: .Normal)
        cell.bottomBtn.setTitle("马上发货", forState: .Normal)
        cell.bottomBtn.tag = indexPath.row
        cell.bottomBtn.addTarget(self, action: #selector(self.ClcikBottomBtn), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = OrderDetailsViewController()
        vc.hidesBottomBarWhenPushed = true
        let model = dataArray[indexPath.row] as! OrderListModel
        vc.dataSource = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ClcikBottomBtn(btn:UIButton){
        let vc = SendGoodsViewController()
        vc.hidesBottomBarWhenPushed = true
        let model = dataArray[btn.tag] as! OrderListModel
        vc.dataArray = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
