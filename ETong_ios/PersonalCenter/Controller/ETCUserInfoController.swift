//
//  ETCUserInfoController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/2.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETCUserInfoController: UIViewController {
    
    @IBOutlet weak var avatarView:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userSex:UILabel!
    @IBOutlet weak var phoneNum:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改资料"
        avatarView.layer.cornerRadius = 25
        avatarView.clipsToBounds = true
        if ETUserInfo.sharedETUserInfo().isLogin {
            avatarView.sd_setImageWithURL(NSURL(string: kIMAGE_URL_HEAD+ETUserInfo.sharedETUserInfo().photo), placeholderImage: UIImage(named: "ic_touxiang"))
            userName.text = ETUserInfo.sharedETUserInfo().name
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !ETUserInfo.sharedETUserInfo().isLogin {
            SVProgressHUD.showErrorWithStatus("请先登录")
            navigationController?.popViewControllerAnimated(true)
        }
    }
    //修改头像
    @IBAction func editAvatarAction(sender: AnyObject){
    }
    
    @IBAction func editNameAction(sender: AnyObject){
        let vc = ETSingleInfoController(nibName: "ETSingleInfoController", bundle: nil)
        vc.title = "修改昵称"
        vc.setInfoHandle { [unowned self] (str) in
            self.userName.text = str
        }
        vc.infoText = userName.text!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editSexAction(sender: AnyObject){
    }
    
    @IBAction func editPhoneNum(sender: AnyObject){
        let vc = ETSingleInfoController(nibName: "ETSingleInfoController", bundle: nil)
        vc.title = "修改手机"
        vc.infoText = ETUserInfo.sharedETUserInfo().phone
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func reciveAddress(sender: AnyObject){
    }
}