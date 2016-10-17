//
//  ETOrderManagerController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/1.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETOrderManagerController: YPTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.mainScreen().bounds.size
        self.setTabBarFrame(CGRectMake(0, 0, screenSize.width, 44), contentViewFrame: CGRectMake(0, 44, screenSize.width, screenSize.height - 64 - 42))
        self.tabBar.itemTitleColor = UIColor.lightGrayColor()
        self.tabBar.itemTitleSelectedColor = UIColor.redColor()
        self.tabBar.itemTitleFont = UIFont.systemFontOfSize(17)
        
        self.tabBar.setScrollEnabledAndItemWidth(screenSize.width/4)
        self.tabBar.itemFontChangeFollowContentScroll = true
        self.tabBar.itemSelectedBgScrollFollowContent = true
        self.tabBar.itemSelectedBgColor = UIColor.redColor()
        self.tabBar.setItemSelectedBgInsets(UIEdgeInsetsMake(42, 0, 0, 0), tapSwitchAnimated: true)
        self.setContentScrollEnabledAndTapSwitchAnimated(true)
        
        self.title = "订单管理"
        addControllers()
    }
    
    func addControllers() {
        let vc1 = ETAllOrderController(nibName: "ETAllOrderController", bundle: nil)
        vc1.yp_tabItemTitle = "全部"
        
        let vc2 = NoDeliveryViewController()
        vc2.yp_tabItemTitle = "待发货"
        
        let vc3 = NOSignedViewController()
        vc3.yp_tabItemTitle = "待签收"
        
        let vc4 = HaveDoneViewController()
        vc4.yp_tabItemTitle = "已完成"
        
        self.viewControllers = [vc1,vc2,vc3,vc4]
    }
}