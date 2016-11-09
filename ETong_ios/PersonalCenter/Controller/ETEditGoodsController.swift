//
//  ETEditGoodsController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/15.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETEditGoodsController: UITableViewController,SortPickerDelegate {
    
    var titleDataSource = [["商品轮播图","商品描述","商品标题","分类"],["品牌","货号"],["商品规格","现价","原价","运费","库存"],["宝贝详情","发货地"]]
    var goodModel:ETGoodsDataModel?
    var pickerView : SortView?
    var helper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑宝贝"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return titleDataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleDataSource[section].count
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 8
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let view = UIView()
        view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        return view
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = titleDataSource[indexPath.section][indexPath.row]
        cell?.accessoryType = .DisclosureIndicator
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.section*10+indexPath.row == 20 {
            print(goodModel?.id)
            let vc = SpecificationViewController()
            vc.goodsModel = goodModel
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section*10+indexPath.row == 3{
            self.pickerView = SortView.init(frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
            pickerView!.delegate = self
            pickerView!.font = UIFont.systemFontOfSize(16)
            self.view.addSubview(pickerView!)
        }else if indexPath.section * 10 + indexPath.row == 30 {
            let vc = ChangeDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            let vc = ETEditInfoController(nibName: "ETEditInfoController", bundle: nil)
            vc.showForTitle(titleDataSource[indexPath.section][indexPath.row]) { (dic) in
                print(dic)
            }
            vc.infoType = indexPath.section*10+indexPath.row
            vc.goodsModel = goodModel
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func JSAddressCancleAction(senter: AnyObject!) {
        self.pickerView!.removeFromSuperview()
    }
    func JSAddressPickerRerurnBlockWithProvince(province: String!, city: String!, town: String!) {
        
        helper.updateGoodsTypeWithGoodsid(self.goodModel?.id, type: town, success: { (dic) in
//            print(dic)
            SVProgressHUD.showSuccessWithStatus("修改商品分类成功")
            self.pickerView!.removeFromSuperview()
            
            }, faild: { (str, error) in
                
        })
        
    }
}
