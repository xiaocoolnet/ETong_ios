//
//  ETGoodsLoopController.swift
//  ETong_ios
//
//  Created by xiaocool on 16/8/8.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

protocol ETGoodsLoopControllerDelegate:NSObjectProtocol {
    func selectImages(imageNames:Array<String>)
}

class ETGoodsLoopController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var scrollHeight: NSLayoutConstraint!
    @IBOutlet weak var imageList: UITableView!
    var myActionSheet:UIAlertController?
    var currentBtn:UIButton?
    var imageNames:Array<String> = []
    weak var delegate:ETGoodsLoopControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageList.registerNib(UINib(nibName:"ETGoodsLoopCell", bundle: nil), forCellReuseIdentifier: "cell")
        imageList.tableFooterView = UIView()
        imageList.scrollEnabled = false
        scrollHeight.constant = imageList.contentSize.height + 45
        // 根据图片个数调整view的高度
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
        ConnectModel.uploadWithImageName(imageName, imageData: data, URL: kUPLOAD_URL_HEAD) { [unowned self] (data) in
                st_dispatch_async_main({
                    self.currentBtn?.setImage(image, forState: .Normal)
                    if !self.imageNames.contains(imageName+".png") {
                        self.imageNames.append(imageName+".png")
                    }
                })
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func uploadGoods(sender: AnyObject) {
        print("上传图片")
        delegate?.selectImages(imageNames)
        navigationController?.popViewControllerAnimated(true)
    }
    
    func clickedImageBtn(btn:UIButton){
        currentBtn = btn
        presentViewController(myActionSheet!, animated: true, completion:nil)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 166
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ETGoodsLoopCell
        
        cell.selectionStyle = .None
        cell.imageBtn.tag = indexPath.row
        
        if imageNames.count-1 >= indexPath.row {
            let imageUrl = NSURL(string: kIMAGE_URL_HEAD+imageNames[indexPath.row])
            cell.imageBtn.sd_setImageWithURL(imageUrl, forState: .Normal)
        }
        if indexPath.row == 1 {
            cell.imageAlert.text = "请设置第二张轮播图（非必填）"
        }
        
        else if indexPath.row == 2 {
            cell.imageAlert.text = "请设置第三张轮播图（非必填）"
        }
        
        cell.imageBtn.addTarget(self, action: #selector(clickedImageBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
}
