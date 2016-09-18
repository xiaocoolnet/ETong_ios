//
//  ETGoodsDetailController.swift
//  ETong_ios
//  Created by xiaocool on 16/8/18.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETGoodsDetailController: UIViewController,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var imageBackView:UIView!
    @IBOutlet weak var goodsName:UILabel!
    @IBOutlet weak var express:UILabel!
    @IBOutlet weak var shenma:UILabel!
    @IBOutlet weak var price:UILabel!
    @IBOutlet weak var collectBtn:UIButton!
    @IBOutlet weak var descript:UILabel!
    @IBOutlet weak var judgeList:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        judgeList.registerNib(UINib(nibName: "ETGoodsJudgeCell",bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        title = "宝贝详情"
        print("进来了")
    }
    
    override func viewDidAppear(animated: Bool) {
        let imageNames = ["ic_lunbotu","ic_lunbotu","ic_lunbotu","ic_lunbotu"]
        let cycleScrollView = SDCycleScrollView.init(frame: CGRectMake(0, 0, imageBackView.frame.width, imageBackView.frame.height), shouldInfiniteLoop: true, imageNamesGroup: imageNames)
        cycleScrollView.delegate = self
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        imageBackView.addSubview(cycleScrollView)
        cycleScrollView.scrollDirection = .Horizontal
    }
    
    func createData(){
        let model0 = GoodAttrModel()
        model0.attr_id = "10"
        model0.attr_name = "尺寸"
        
        let model1 = GoodAttrModel()
        model1.attr_id = "11"
        model1.attr_name = "颜色"
        
    }
    
    @IBAction func immediatelyBuy(sender: AnyObject) {
        let model0 = GoodAttrModel()
        model0.attr_id = "10"
        model0.attr_name = "尺寸"
        
        let model1 = GoodAttrModel()
        model1.attr_id = "11"
        model1.attr_name = "颜色"
        
        let view = GoodAttributesView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        view.goodAttrsArr = [model0,model1]
        view.showInView(self.view)
    }
    
    @IBAction func addToShopCart(sender: AnyObject) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        return cell!
    }
}
