//
//  ETShopManagerController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/7/31.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ETShopManagerController: UIViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var shopModel:ETShopModel?
    
    @IBOutlet weak var shopImage:UIImageView!
    @IBOutlet weak var shopName:UITextField!
    @IBOutlet weak var backImage:UILabel!
    @IBOutlet weak var descrpt:UILabel!
    @IBOutlet weak var linkWay:UILabel!
    @IBOutlet weak var shopAddress:UILabel!
    @IBOutlet weak var sendAddress:UILabel!
    @IBOutlet weak var receive:UILabel!
    var myActionSheet:UIAlertController?
    var helper:ETShopHelper = ETShopHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "店铺信息"
        // Do any additional setup after loading the view.
        
        shopName.delegate = self
        
        if shopModel != nil {
            shopImage.sd_setImageWithURL(NSURL(string:kIMAGE_URL_HEAD+(shopModel?.photo)!), placeholderImage: UIImage(named: "ic_touxiang"))
            shopName.text = shopModel?.shopname
            shopAddress.text = shopModel?.address
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
    
    @IBAction func clickImgButton(sender: AnyObject) {
        presentViewController(myActionSheet!, animated: true, completion:nil)
    }
    
    @IBAction func clickShopNameButton(sender: AnyObject) {
        
        let vc = ChangeShopViewController()
        vc.title = "修改店铺昵称"
        vc.hidesBottomBarWhenPushed = true
        vc.changeType = 0
        vc.setInfoHandle { [unowned self] (str) in
            self.shopName.text = str
        }
        vc.strId = (self.shopModel?.id)!
        vc.infoText = shopName.text!

        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func clickShopDescrptButton(sender: AnyObject) {
        
    }
    
    @IBAction func clickTypeButton(sender: AnyObject) {
    }

    @IBAction func clickAddressButton(sender: AnyObject) {
        
        let vc = ChangeShopViewController()
        vc.title = "修改店铺地址"
        vc.hidesBottomBarWhenPushed = true
        vc.changeType = 4
        vc.setInfoHandle { [unowned self] (str) in
            self.shopAddress.text = str
        }
        vc.strId = (self.shopModel?.id)!
        vc.infoText = shopAddress.text!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickSendButton(sender: AnyObject) {
    }
    
    @IBAction func clickReceiveButton(sender: AnyObject) {
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
        let imageName = "avatar" + dateStr + ETUserInfo.sharedETUserInfo().Id
        ConnectModel.uploadWithImageName(imageName, imageData: data, URL: kUPLOAD_URL_HEAD) {  (data) in
            self.helper.upLoadShopInfoWithId(self.shopModel?.id, photo: imageName+".png", success: {[unowned self] (dic) in
                st_dispatch_async_main({
                    SVProgressHUD.showSuccessWithStatus("修改店铺头像成功")
                    self.shopImage.image = image
                })
                }, faild: nil)
            
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
