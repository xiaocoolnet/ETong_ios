//
//  AllOrderViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/9/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class AllOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.AddTableView()
        
    }

    func AddTableView(){
        tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 44)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerNib(UINib(nibName: "AllOrderTableViewCell",bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! AllOrderTableViewCell
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        let model = dataSource[indexPath.row] as! OrderListModel
//        cell.nameLab.text = model.peoplename
        cell.sizeNumLab.text = model.number
        cell.moneyLab.text = "¥" + (model.money)
        cell.stateLab.text = model.statusname
        cell.titleLab.text = model.goodsname
        cell.btn.layer.borderWidth = 1
        cell.btn.layer.borderColor = UIColor.redColor().CGColor
        cell.btn.layer.cornerRadius = 10
        if cell.stateLab.text == "未付款"{
            cell.cancelBtn.hidden = false
            cell.cancelBtn.layer.borderWidth = 1
            cell.cancelBtn.layer.borderColor = UIColor.lightGrayColor().CGColor
            cell.cancelBtn.layer.cornerRadius = 10
            cell.cancelBtn.tag = indexPath.row
            cell.cancelBtn.addTarget(self, action: #selector(self.clickCancle), forControlEvents: .TouchUpInside)
        }else{
            cell.cancelBtn.hidden = true
        }
        
        let strArray = model.picture.componentsSeparatedByString(",")
        let str = kIMAGE_URL_HEAD + strArray.first!
        let photourl = NSURL(string: str)
        cell.imgView.sd_setImageWithURL(photourl, placeholderImage: UIImage(named: "ic_xihuan"))
        return cell
    }

    func clickCancle(sender:UIButton){
        let vc = CancleOrderViewController()
        vc.hidesBottomBarWhenPushed = true
        let model = dataSource[sender.tag] as! OrderListModel
        vc.strid = model.id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
