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
    
    var shopModel:ETShopModel?
    var helper:ETShopHelper = ETShopHelper()
    var dataSource = NSMutableArray()
    var listType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝贝管理"
        goodsList.registerNib(UINib(nibName: "ETGMSellCell",bundle: nil), forCellReuseIdentifier: "cell1")
        goodsList.registerNib(UINib(nibName: "ETGMOffShelfCell",bundle: nil), forCellReuseIdentifier: "cell2")
    }
    
    override func viewDidAppear(animated: Bool) {
        getNetData()
    }
    
    func getNetData(){
        helper.getShopGoodsListWithShopid(shopModel?.id, userid: ETUserInfo.sharedETUserInfo().id, xiajia: listType == 0 ? nil : "1", success: { [unowned self](dic) in
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
    func deleteGoodsAction(btn:UIButton){
        print(btn.tag)
        let alert = UIAlertView(title: "是否确定要下架", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "下架")
        alert.show()
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
            cell.offSaleBtn.addTarget(self, action: #selector(deleteGoodsAction), forControlEvents: .TouchUpInside)
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if listType == 0 {
            let vc = ETGoodsDetailController(nibName: "ETGoodsDetailController", bundle: nil)
            vc.goodModel = dataSource[indexPath.row] as? ETGoodsDataModel
            print(vc.goodModel?.price)
            vc.str = 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func segmentValueChanged(control: UISegmentedControl) {
        listType = control.selectedSegmentIndex
        getNetData()
    }
}
