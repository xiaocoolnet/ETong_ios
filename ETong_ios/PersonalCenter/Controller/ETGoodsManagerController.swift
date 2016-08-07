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
    var listType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝贝管理"
        goodsList.registerNib(UINib(nibName: "ETGMSellCell",bundle: nil), forCellReuseIdentifier: "cell1")
        
        goodsList.registerNib(UINib(nibName: "ETGMOffShelfCell",bundle: nil), forCellReuseIdentifier: "cell2")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if listType == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1")
            return cell!
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2")
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
