//
//  ETSingleInfoController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/2.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

typealias SingleInfoHandle = (str :String) -> Void

class ETSingleInfoController: UIViewController {
    
    @IBOutlet weak var changeInfo:UITextField!
    var infoText = ""
    var myHandle:SingleInfoHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeInfo.text = infoText
        let rightButton = UIButton(type: .Custom)
        rightButton.frame = CGRectMake(0, 0, 50, 30)
        rightButton.setTitle("保存", forState: .Normal)
        rightButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightButton.addTarget(self, action: #selector(rightBarButtonClicked), forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    func rightBarButtonClicked(){
        if myHandle != nil {
            myHandle!(str: changeInfo.text!)
        }
        navigationController?.popViewControllerAnimated(true)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        changeInfo.becomeFirstResponder()
    }
    
    func setInfoHandle(handle:SingleInfoHandle){
        myHandle = handle
    }
}
