//
//  ETGoodsManagerController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETGoodsManagerController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var goodsList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentView: UISegmentedControl!
    var shopModel:ETShopModel?
    var helper:ETShopHelper = ETShopHelper()
    var dataSource = NSMutableArray()
    var listType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝贝管理"
        goodsList.registerNib(UINib(nibName: "ETGMSellCell",bundle: nil), forCellReuseIdentifier: "cell1")
        goodsList.registerNib(UINib(nibName: "ETGMOffShelfCell",bundle: nil), forCellReuseIdentifier: "cell2")
        helper.getShopGoodsListWithShopid(shopModel?.id, userid: ETUserInfo.sharedETUserInfo().id, xiajia: nil, success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataSource.addObjectsFromArray(models as! [ETGoodsDataModel])
            st_dispatch_async_main({
                self.goodsList.reloadData()
            })
            }, faild: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if listType == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! ETGMSellCell
            cell.showForModel(dataSource[indexPath.row] as! ETGoodsDataModel)
            cell.selectionStyle = .None
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2")
            cell?.selectionStyle = .None
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 170
    }
    
    @IBAction func segmentValueChanged(control: UISegmentedControl) {
        listType = control.selectedSegmentIndex
        goodsList.reloadData()
    }
}
