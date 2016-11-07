//
//  SpecificationViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/26.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class SpecificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    let dataSource = NSMutableArray()
    var goodsModel:ETGoodsDataModel?
    var helper:ETShopHelper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "添加商品规格"
        AddTableView()
        GetDate()
    }
    
    func GetDate(){
        helper.GetGoodsAttributesInfoWithType("1", success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataSource.removeAllObjects()
            self.dataSource.addObjectsFromArray(models as! [AttributesModel])
            st_dispatch_async_main({
                self.tableView.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({
                    self.dataSource.removeAllObjects()
                    self.tableView.reloadData()
                })
        })
    }

    func AddTableView(){
        tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "cell1")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        cell.accessoryType = .DisclosureIndicator
        let model = self.dataSource[indexPath.row] as! AttributesModel
        cell.textLabel?.text = model.name
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        
        let line = UILabel()
        line.frame = CGRectMake(0, 49, self.view.frame.size.width, 1)
        line.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        cell.contentView.addSubview(line)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = SelectViewController()
        vc.goodid = goodsModel?.id
        vc.goodModel = self.dataSource[indexPath.row] as? AttributesModel
        vc.type = ((self.dataSource[indexPath.row] as? AttributesModel)?.termid)!
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
