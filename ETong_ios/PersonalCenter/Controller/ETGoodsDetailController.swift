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
    var imageNames = Array<String>()
    var goodModel:ETGoodsDataModel?
    var valueArr = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = false
        judgeList.registerNib(UINib(nibName: "ETGoodsJudgeCell",bundle: nil), forCellReuseIdentifier: "cell")
        createData()
        // Do any additional setup after loading the view.
        title = "宝贝详情"
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let cycleScrollView = SDCycleScrollView(frame: CGRectMake(0, 0, imageBackView.frame.width, imageBackView.frame.height), delegate: self, placeholderImage: UIImage(named: "ic_lunbotu"))
        cycleScrollView.delegate = self
        cycleScrollView.imageURLStringsGroup = imageNames
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        imageBackView.addSubview(cycleScrollView)
        cycleScrollView.scrollDirection = .Horizontal
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
        
        if goodModel == nil {
            return
        }
        
        goodsName.text = goodModel!.goodsname
        imageNames = goodModel!.picture.componentsSeparatedByString(",")
        imageNames = imageNames.filter { (str) -> Bool in
            return !str.isEmpty
        }
        var images = Array<String>()
        for str in imageNames {
            let imageStr = kIMAGE_URL_HEAD + str;
            images.append(imageStr)
        }
        imageNames = images
        descript.text = goodModel?.description
        shenma.text = goodModel?.address
        
    }
    
    func showPropertyView(){
        let editView = GoodAttributesView(frame: CGRectMake(0, 0, self.navigationController!.view.frame.width, self.navigationController!.view.frame.height))
        editView.goodAttrsArr = valueArr as [AnyObject]
        editView.sureBtnsClick = {(str:String!,str2:String!,str3:String!,str4:String!) in
            
        }
        editView.showInView(self.navigationController?.view)
    }
    
    @IBAction func immediatelyBuy(sender: AnyObject) {
       showPropertyView()
    }
    
    @IBAction func addToShopCart(sender: AnyObject) {
        if goodModel == nil {
            return;
        }
        ETShopHelper().addShoppingCartWithShopid(goodModel?.shopid, goodsid: goodModel?.id, goodsnum: "1", success: { (_: [NSObject : AnyObject]!) in
            
            }) { (String, NSError) in
                
        }
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
