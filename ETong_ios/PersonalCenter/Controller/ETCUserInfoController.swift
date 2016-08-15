//
//  ETCUserInfoController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/2.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETCUserInfoController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate {
    
    @IBOutlet weak var avatarView:UIImageView!
    @IBOutlet weak var userName:UILabel!
    @IBOutlet weak var userSex:UILabel!
    @IBOutlet weak var phoneNum:UILabel!
    var myActionSheet:UIAlertController?
    var helper:ETShopHelper = ETShopHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改资料"
        avatarView.layer.cornerRadius = 25
        avatarView.clipsToBounds = true
        if ETUserInfo.sharedETUserInfo().isLogin {
            avatarView.sd_setImageWithURL(NSURL(string: kIMAGE_URL_HEAD+ETUserInfo.sharedETUserInfo().photo), placeholderImage: UIImage(named: "ic_touxiang"))
            userName.text = ETUserInfo.sharedETUserInfo().name
            userSex.text = Int(ETUserInfo.sharedETUserInfo().sex) == 1 ? "男" : "女"
        }
        myActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        myActionSheet?.addAction(UIAlertAction(title: "拍照", style: .Default, handler: {[unowned self] (UIAlertAction) in
            dispatch_async(dispatch_get_main_queue(), {
                self.takePhoto()
            })
        }))
        
        myActionSheet?.addAction(UIAlertAction(title: "从相册获取", style: .Default, handler: { [unowned self] (UIAlertAction) in
            dispatch_async(dispatch_get_main_queue(), {
                self.LocalPhoto()
            })
        }))
        
        myActionSheet?.addAction(UIAlertAction(title: "取消", style: .Cancel, handler:nil))
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !ETUserInfo.sharedETUserInfo().isLogin {
            SVProgressHUD.showErrorWithStatus("请先登录")
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func takePhoto(){
        
        let sourceType = UIImagePickerControllerSourceType.Camera
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            self.presentViewController(picker, animated: true, completion: nil)
        }else{
            print("无法打开相机")
        }
    }
    
    func LocalPhoto(){
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let type = info[UIImagePickerControllerMediaType] as! String
        if type != "public.image" {
            return
        }
        //裁剪后图片
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        let data = UIImageJPEGRepresentation(image, 0.1)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr = dateFormatter.stringFromDate(NSDate())
        let imageName = "avatar" + dateStr + ETUserInfo.sharedETUserInfo().id
        ConnectModel.uploadWithImageName(imageName, imageData: data, URL: kUPLOAD_URL_HEAD) {  (data) in
                self.helper.updataUserAvatarWithUserid(ETUserInfo.sharedETUserInfo().id, avatar: imageName+".png", success: {[unowned self] (dic) in
                    st_dispatch_async_main({
                        SVProgressHUD.showSuccessWithStatus("修改头像成功")
                        self.avatarView.image = image
                    })
                    }, faild: nil)

        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    //修改头像
    @IBAction func editAvatarAction(sender: AnyObject){
         presentViewController(myActionSheet!, animated: true, completion:nil)
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
        let alert = UIAlertView(title: "", message: "请选择性别", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "男", "女")
        alert.show()
    }
    
    @IBAction func editPhoneNum(sender: AnyObject){
        let vc = ETSingleInfoController(nibName: "ETSingleInfoController", bundle: nil)
        vc.title = "修改手机"
        vc.changeType = 1
        vc.infoText = ETUserInfo.sharedETUserInfo().phone
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func reciveAddress(sender: AnyObject){
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        
        if buttonIndex == 0 {
            return
        }
        
        let num = buttonIndex == 1 ? 1 : 0
        helper.updataUserSexWithUserid(ETUserInfo.sharedETUserInfo().id, sex: num, success: {[unowned self] (dic) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("修改成功")
                    self.navigationController?.popViewControllerAnimated(true)
                })
            }) { (str, err) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("修改失败")
                })
            }
    }
}