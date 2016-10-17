//
//  OrderDetailsViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/14.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    let headView = UIView()
    let footView = UIView()
    var dataSource = OrderListModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "订单详情"
        AddTableView()
    }
    
    func AddTableView(){
        tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 44)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerNib(UINib(nibName: "OrderDetailsTableViewCell",bundle: nil), forCellReuseIdentifier: "cell1")
        self.headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 170);
        self.headView.backgroundColor = UIColor.whiteColor()
        self.tableView.tableHeaderView = headView
        // 添加头视图
        addHeaderView()
        // 添加尾视图
        self.footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 170)
        self.footView.backgroundColor = UIColor.whiteColor()
        self.tableView.tableFooterView = footView
        addFooterView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 195
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! OrderDetailsTableViewCell
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        cell.goodname.text = dataSource.goodsname
        cell.numLab.text = "数量" + dataSource.number
        cell.priceLab.text = "￥" + dataSource.price
        let strArray = dataSource.picture.componentsSeparatedByString(",")
        let str = kIMAGE_URL_HEAD + strArray.first!
        let photourl = NSURL(string: str)
        cell.imgView.sd_setImageWithURL(photourl, placeholderImage: UIImage(named: "ic_xihuan"))
        
        return cell
    }
    // 添加透视图
    func addHeaderView(){

        let aview = UIView()
        aview.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
        aview.backgroundColor = UIColor(red: 253/255, green: 74/255, blue: 75/255, alpha: 1)
        headView.addSubview(aview)
        
        let stateLab = UILabel()
        stateLab.frame = CGRectMake(30, 0, 100, 100)
        stateLab.textColor = UIColor.whiteColor()
        if dataSource.states == "1" {
            stateLab.text = "订单代付款"
        }else if dataSource.states == "2"{
            stateLab.text = "买家已付款"
        }else if dataSource.states == "3"{
            stateLab.text = "卖家已发货"
        }else if dataSource.states == "4"{
            stateLab.text = "交易成功"
        }else{
            stateLab.text = "卖家已发货"
        }
        aview.addSubview(stateLab)
        let imgView = UIImageView()
        imgView.frame = CGRectMake(self.view.frame.size.width - 100, 20, 60, 60)
        imgView.image = UIImage(named: "ic_yifahuo")
        aview.addSubview(imgView)
        
        let nameLab = UILabel()
        nameLab.frame = CGRectMake(40, 110, 130, 20)
        nameLab.textColor = UIColor.lightGrayColor()
        nameLab.text = dataSource.username
        headView.addSubview(nameLab)
        
        let img = UIImageView()
        img.frame = CGRectMake(10, 125, 20, 30)
        img.image = UIImage(named: "ic_bendi_hui")
        headView.addSubview(img)
        
        let phoneLab = UILabel()
        phoneLab.frame = CGRectMake(170, 110, self.view.frame.size.width - 180, 20)
        phoneLab.textColor = UIColor.lightGrayColor()
        phoneLab.textAlignment = .Right
        phoneLab.text = dataSource.mobile
        headView.addSubview(phoneLab)
        
        let addressLab = UILabel()
        addressLab.frame = CGRectMake(40, 140, self.view.frame.size.width - 40, 20)
        addressLab.textColor = UIColor.lightGrayColor()
        addressLab.text = dataSource.address
        headView.addSubview(addressLab)
    }
    // 添加尾视图
    func addFooterView(){
        let dataArray = NSMutableArray()
        for i in 0...5 {
            let lable = UILabel()
            lable.frame = CGRectMake(10, (10 + CGFloat(i) * 25), self.view.frame.size.width - 10, 25)
            lable.textColor = UIColor.lightGrayColor()
            lable.font = UIFont.systemFontOfSize(14)
            footView.addSubview(lable)
            dataArray.addObject(lable)
        }
        
        (dataArray[0] as! UILabel).text = "订单编号: " + dataSource.order_num
        (dataArray[1] as! UILabel).text = "支付方式: 支付宝"
        let dateformate = NSDateFormatter()
        dateformate.dateFormat = "yyyy-MM-dd HH:mm"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(dataSource.time)!)
        let str:String = dateformate.stringFromDate(date)
        (dataArray[2] as! UILabel).text = "创建时间: " + str
        (dataArray[3] as! UILabel).text = "付款时间: 2016.8.20 18:27"
        (dataArray[4] as! UILabel).text = "发货时间: 2016.8.20 18:27"
        (dataArray[5] as! UILabel).text = "成交时间: 2016.8.20 18:27"
    }


}
