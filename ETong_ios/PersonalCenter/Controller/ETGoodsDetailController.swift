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
    var strId = NSString()
    var shopid = NSString()
    var shopname = NSString()
    var navgationType = String()
    var dic = NSDictionary()
    
    var imageNames = Array<String>()
    var goodModel:ETGoodsDataModel?
    var valueArr = NSArray()
    var str = 0
    var model = NewProductModel()
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = false
        judgeList.registerNib(UINib(nibName: "ETGoodsJudgeCell",bundle: nil), forCellReuseIdentifier: "cell")
        createData()
        // Do any additional setup after loading the view.
        title = "宝贝详情"
        collectBtn.setImage(UIImage(named: "ic_weishoucang"), forState: .Normal)
        collectBtn.setImage(UIImage(named: "ic_cainixihuan-1"), forState: .Highlighted)
        collectBtn.setImage(UIImage(named: "ic_cainixihuan-1"), forState: .Selected)
        collectBtn.selected = false
        getShopDetail()
        GetGoodsComments()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        let cycleScrollView = SDCycleScrollView(frame: CGRectMake(0, 0, imageBackView.frame.width, imageBackView.frame.height), delegate: self, placeholderImage: UIImage(named: "ic_lunbotu"))
        cycleScrollView.delegate = self
        cycleScrollView.imageURLStringsGroup = imageNames
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        imageBackView.addSubview(cycleScrollView)
        cycleScrollView.scrollDirection = .Horizontal
        
        let imgBtn = UIButton()
        imgBtn.frame = CGRectMake(imageBackView.frame.size.width - 60, 5, 50, 50)
        imgBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        imgBtn.setTitle("图文", forState: .Normal)
        imgBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        imgBtn.addTarget(self, action: #selector(self.clickImgBtn), forControlEvents: .TouchUpInside)
        imgBtn.layer.cornerRadius = 25
        imgBtn.layer.masksToBounds = true
        imageBackView.addSubview(imgBtn)
        
        goodsName.text = goodModel!.goodsname
        price.text = "¥" +  goodModel!.price
        express.text = "快递: " + (goodModel?.price)!
        shenma.text = goodModel!.address
        descript.text = goodModel!.description
        
    }
    
    func clickImgBtn(){
        print(1111)
        let vc = TextPicViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.goodModel = goodModel
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    // 店铺
    @IBAction func ClickShopButton(sender: AnyObject) {
        let vc = GoShopViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.dictionary = self.dic as [NSObject : AnyObject]
        vc.navgationType = self.navgationType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addToShopCart(sender: AnyObject) {
        if goodModel == nil {
            return;
        }
        if (!ETUserInfo.sharedETUserInfo().isLogin) {
            SVProgressHUD.showErrorWithStatus("请先登录")
            return
        }
        ETShopHelper().addShoppingCartWithShopid(goodModel?.shopid, goodsid: goodModel?.id, goodsnum: "1", success: { (_: [NSObject : AnyObject]!) in
            
            }) { (String, NSError) in
                
        }
    }
    
    @IBAction func ClickCollectBtn(sender: AnyObject) {
        
        print(111)
        if goodModel == nil {
            return;
        }
        if (!ETUserInfo.sharedETUserInfo().isLogin) {
            SVProgressHUD.showErrorWithStatus("请先登录")
            return
        }
        if collectBtn.selected {
            ETShopHelper().cancleCollectionWithUserid(ETUserInfo.sharedETUserInfo().Id, goodsid: goodModel?.id, type: "1", success: {[unowned self] (dic) in
                st_dispatch_async_main({
                    self.collectBtn.selected = false
                    SVProgressHUD.showSuccessWithStatus("取消收藏成功")
                })
            }) { (str, err) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("取消收藏失败")
                })
            }
        }else{
            ETShopHelper().collectionGoodsWithUserid(ETUserInfo.sharedETUserInfo().Id, goodsid: goodModel?.id, type: "1", title: goodModel?.goodsname, description: goodModel?.description, success: {[unowned self] (dic) in
                st_dispatch_async_main({
                    print(self.goodModel?.id)
                    print(self.goodModel?.goodsname)
                    print(ETUserInfo.sharedETUserInfo().Id)
                    print(self.goodModel?.description)
                   
                    self.collectBtn.selected = true
                    SVProgressHUD.showSuccessWithStatus("收藏成功")
                })
            }) { (str, err) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("收藏失败")
                })
            }
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 111
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ETGoodsJudgeCell
        cell.selectionStyle = .None
        let model = dataArray[indexPath.row] as! GoodsCommentmodel
        print(model.user_info.first!["name"])
        cell.userName.text = (model.user_info.first!["name"]) as? String
        cell.descript.text = model.content
        let dateformat = NSDateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(model.add_time)!)
        let st:String = dateformat.stringFromDate(date)
        cell.infoLabel.text = st + "  颜色: 图片色 尺码: 5"
        let pict = (model.user_info.first!["photo"]) as? String
        let imgUrl = kIMAGE_URL_HEAD + pict!
        let photourl = NSURL(string: imgUrl)
        cell.avatarBtn.layer.cornerRadius = 19
        cell.avatarBtn.layer.masksToBounds = true
        cell.avatarBtn.sd_setImageWithURL(photourl, forState: .Normal, placeholderImage: UIImage(named: "ic_xihuan"))
        return cell
        
    }
    @IBAction func ClickTalkBtn(sender: AnyObject) {
        let vc = ChetViewController()
        vc.receive_uid = self.strId as String
        vc.title = self.shopname as String
//        print(vc.receive_uid)
        if ETUserInfo.sharedETUserInfo().Id == self.strId {
            SVProgressHUD.showErrorWithStatus("这是您自己的店铺，不能和自己聊天")
            return
        }
        if (!ETUserInfo.sharedETUserInfo().isLogin) {
            SVProgressHUD.showErrorWithStatus("请先登录")
            return
        }
        vc.navgationType = self.navgationType
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getShopDetail(){
        ETShopHelper().GetShopDetailsWithShopid(goodModel?.shopid, success: {[unowned self] (dic) in
            st_dispatch_async_main({
                self.strId = dic["uid"] as! String
                self.shopid = dic["id"] as! String
                print(dic["shopname"])
                if ((dic["shopname"]?.isMemberOfClass(NSNull)) != nil){
                    self.shopname = "无"
                }else{
                    
                    self.shopname = dic["shopname"] as! String
                }
                print(dic["uid"])
                self.dic = dic
            })
        }) { (str, err) in
            st_dispatch_async_main({
                SVProgressHUD.showSuccessWithStatus("网络错误")
            })
        }
    }
    
    
    // 获取商品评论信息数据
    func GetGoodsComments(){
        ETShopHelper().GetGoodscommentWithGoodid(goodModel?.id, success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(models as! [GoodsCommentmodel])
            st_dispatch_async_main({
                self.judgeList.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({
                    self.dataArray.removeAllObjects()
                    self.judgeList.reloadData()
                })
        })
    }
    
}
