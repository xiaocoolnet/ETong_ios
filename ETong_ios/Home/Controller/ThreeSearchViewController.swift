//
//  ThreeSearchViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/25.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ThreeSearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var str = NSString()
    let leftBtn = UIButton()
    let tableView = UITableView()
    var helper:EveryDayHelper = EveryDayHelper()
    var dataArray = NSMutableArray()
    var aview = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.hidden = true
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.navigationItem.hidesBackButton = true;//可以隐藏原有的导航栏返回按钮
        self.leftBtn.frame = CGRectMake(0, 0, 30, 30);
        leftBtn.setImage(UIImage(named: "Unknown"), forState: .Normal)
        leftBtn.addTarget(self, action: #selector(clickBack), forControlEvents: .TouchUpInside)
        self.leftBtn.contentHorizontalAlignment = .Left
        let item3 = UIBarButtonItem()
        item3.customView = self.leftBtn
        self.navigationItem.leftBarButtonItem = item3;
        
        let titleBtn = UIButton()
        titleBtn.frame = CGRectMake(0, 0, 250, 30)
        titleBtn.backgroundColor = UIColor(red: 231/255, green: 82/255, blue: 80/255, alpha: 1)
        titleBtn.addTarget(self, action: #selector(self.clickTitleBtn), forControlEvents: .TouchUpInside)
        titleBtn.setImage(UIImage(named: "sousou"), forState: .Normal)
        titleBtn.setTitle("请输入相关信息", forState: .Normal)
        titleBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        titleBtn.layer.cornerRadius = 10
        self.navigationItem.titleView = titleBtn
        
        addSelectBtn()
        addTableView()
        GetDefaultData()
    }
    
    func clickTitleBtn(){
        print(1111)
        let vc = TwoSearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // 返回按钮跳转首页
    func clickBack(){
        let vc = ClassificationViewController()
        var target:UIViewController?
        
        for controller in (self.navigationController?.viewControllers)! {
            if controller.isKindOfClass(vc .classForCoder) {
                target = controller
            }
        }
        if (target != nil) {
            self.navigationController?.popToViewController(target!, animated: true)
        }
    }
    
    func GetDefaultData(){
        helper.GetSearchGoodsInfoWithGoods(self.str as String, success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(models as! [ETGoodsDataModel])
            st_dispatch_async_main({
                self.tableView.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({
                    self.dataArray.removeAllObjects()
                    self.tableView.reloadData()
                })
        })
    }
    
    func addSelectBtn(){
        let arr = ["默认","销量"]
        for i in 0...1 {
            let btn = UIButton()
            btn.frame = CGRectMake(self.view.frame.size.width/2 * CGFloat(i), 0, self.view.frame.size.width/2, 40)
            btn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.setTitle(arr[i], forState: .Normal)
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(self.clickSelectButton), forControlEvents: .TouchUpInside)
            self.view.addSubview(btn)
        }
    }
    
    func clickSelectButton(sender:UIButton){
        if sender.tag == 1000 {
            addSortView()
        }else{
            
        }
    }
    
    func addTableView(){
        tableView.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40 - 64)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerNib(UINib(nibName: "SearchTableViewCell",bundle: nil), forCellReuseIdentifier: "cell1")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 81
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! SearchTableViewCell
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        
        let model = dataArray[indexPath.row] as! ETGoodsDataModel
        cell.goosname.text = model.goodsname
        cell.priceLb.text = model.price
        cell.opriceLab.text = model.oprice
        let strArray = model.picture.componentsSeparatedByString(",")
        let str = kIMAGE_URL_HEAD + strArray.first!
        let photourl = NSURL(string: str)
        cell.imgView.sd_setImageWithURL(photourl, placeholderImage: UIImage(named: "ic_xihuan"))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = ETGoodsDetailController(nibName: "ETGoodsDetailController", bundle: nil)
        vc.goodModel = self.dataArray[indexPath.item] as? ETGoodsDataModel
        vc.goodModel!.uid = (self.dataArray[indexPath.item] as? ETGoodsDataModel)?.shopid
        vc.hidesBottomBarWhenPushed = true
        vc.navgationType = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func addSortView(){
        self.aview = UIView()
        aview.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)
        aview.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        self.view.window!.addSubview(aview)
        let arr = ["综合排序","上新时间","价格从低到高","价格从高到低"]
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.keyboardHidden))
        //            手指头
        tap.numberOfTapsRequired = 1
        //            单击
        tap.numberOfTouchesRequired = 1
        aview.addGestureRecognizer(tap)
        for i in 0...3 {
            let btn = UIButton()
            btn.frame = CGRectMake(0, 50 + CGFloat(i)*40, self.view.frame.size.width, 40)
            btn.backgroundColor = UIColor.whiteColor()
            btn.titleLabel?.font = UIFont.systemFontOfSize(15)
            btn.setTitle(arr[i], forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.tag = 1 + i
            btn.addTarget(self, action: #selector(self.clickSortButton), forControlEvents: .TouchUpInside)
            aview.addSubview(btn)
            // button标题居左显示
            btn.contentHorizontalAlignment = .Left;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        }
    }
    
    func clickSortButton(sender:UIButton){
        let sortStr = String(sender.tag)
        
        if sender.tag == 1 {
            getsearchSortGood(sortStr)
            
        }else if sender.tag == 2{
            getsearchSortGood(sortStr)
        }else if sender.tag == 3{
            getsearchSortGood(sortStr)
        }else{
            getsearchSortGood(sortStr)
        }
        self.aview.removeFromSuperview()
    }
    
    func keyboardHidden(){
        self.aview.removeFromSuperview()
    }
    
    func getsearchSortGood(sortStr:String){
        print(sortStr)
        helper.GetSearchGoodsInfoWithGoods(self.str as String, sort: sortStr, success: { [unowned self](dic) in
            let models = (dic as NSDictionary).objectForKey("goods")
            self.dataArray.removeAllObjects()
            self.dataArray.addObjectsFromArray(models as! [ETGoodsDataModel])
            st_dispatch_async_main({
                self.tableView.reloadData()
            })
            }, faild: {(str, err) in
                st_dispatch_async_main({
                    self.dataArray.removeAllObjects()
                    self.tableView.reloadData()
                })
        })
    }
}
