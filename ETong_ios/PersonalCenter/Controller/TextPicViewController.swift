//
//  TextPicViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/10/27.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class TextPicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate {

    let tableView = UITableView()
    var imageNames = Array<String>()
    var goodModel:ETGoodsDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        self.title = "图文详情"
        
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
        
        AddTableView()
        
    }

    func AddTableView(){
        tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "cell1")
        AddTableHeaderView()
    }
    
    func AddTableHeaderView(){
        let cycleScrollView = SDCycleScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width, 350), delegate: self, placeholderImage: UIImage(named: "ic_lunbotu"))
        cycleScrollView.delegate = self
        cycleScrollView.imageURLStringsGroup = imageNames
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        cycleScrollView.scrollDirection = .Horizontal
        tableView.tableHeaderView = cycleScrollView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lable = UILabel()
        lable.frame = CGRectMake(0, 0, self.view.frame.size.width, 15)
        
        return lable
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
        cell.selectionStyle = .None
        tableView.separatorStyle = .None
        cell.backgroundColor = UIColor.whiteColor()
        
        let title = UILabel()
        title.frame = CGRectMake(0, 0, self.view.frame.size.width, 30)
        title.text = "商品描述"
        title.font = UIFont.systemFontOfSize(15)
        title.textAlignment = .Center
        cell.contentView.addSubview(title)
        
        let line = UILabel.init(frame: CGRectMake(0, 30, self.view.frame.size.width, 0.5))
        line.backgroundColor = UIColor.lightGrayColor()
        cell.contentView.addSubview(line)
        
        let content = UILabel()
        content.frame = CGRectMake(10, 35, self.view.frame.size.width - 20, 20)
        content.text = goodModel?.description
        content.numberOfLines = 0
        content.sizeToFit()
        content.textColor=UIColor.lightGrayColor()
        cell.contentView.addSubview(content)
        //        自适应行高
        let options : NSStringDrawingOptions = NSStringDrawingOptions.UsesLineFragmentOrigin
        let screenBounds:CGRect = UIScreen.mainScreen().bounds
        let boundingRect = String(content.text).boundingRectWithSize(CGSizeMake(screenBounds.width, 0), options: options, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil)
        let height = boundingRect.size.height + 50
        
        tableView.rowHeight = height
        
        return cell
    }

}
