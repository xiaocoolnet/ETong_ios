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
    var valueArr = NSArray()
    var model = NewProductModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = false
        judgeList.registerNib(UINib(nibName: "ETGoodsJudgeCell",bundle: nil), forCellReuseIdentifier: "cell")
        createData()
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
        
        goodsName.text = model.goodsname
        price.text = "¥" +  model.price
        express.text = "快递: " + model.pays
        shenma.text = model.address
        descript.text = model.descriptio
    }
    
    func createData(){
        let model0 = GoodAttrModel()
        model0.attr_id = "10"
        model0.attr_name = "尺寸"
        let value1 = GoodAttrValueModel()
        value1.attr_value = "165"
        
        let value2 = GoodAttrValueModel()
        value2.attr_value = "170"
        
        let value3 = GoodAttrValueModel()
        value3.attr_value = "175"
        
        let value4 = GoodAttrValueModel()
        value4.attr_value = "180"
        
        let value5 = GoodAttrValueModel()
        value5.attr_value = "185"
        
        let value6 = GoodAttrValueModel()
        value6.attr_value = "190"
        
        model0.attr_value = [value1,value2,value3,value4,value5,value6]
        
        
        let model1 = GoodAttrModel()
        model1.attr_id = "11"
        model1.attr_name = "颜色"
        
        let value10 = GoodAttrValueModel()
        value10.attr_value = "红色"
        let value20 = GoodAttrValueModel()
        value20.attr_value = "蓝色"
        let value30 = GoodAttrValueModel()
        value30.attr_value = "橘红色"
        let value40 = GoodAttrValueModel()
        value40.attr_value = "藏青色"
        
        model1.attr_value = [value10,value20,value30,value40]
        
        valueArr = [model0,model1]
    }
    
    @IBAction func immediatelyBuy(sender: AnyObject) {
        
        let editView = GoodAttributesView(frame: CGRectMake(0, 0, self.navigationController!.view.frame.width, self.navigationController!.view.frame.height))
        editView.goodAttrsArr = valueArr as [AnyObject]
        editView.sureBtnsClick = {(str:String!,str2:String!,str3:String!,str4:String!) in
            print(str+str2+str3+str4)
        }
        editView.showInView(self.navigationController?.view)
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
