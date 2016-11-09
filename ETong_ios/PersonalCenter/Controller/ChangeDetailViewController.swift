//
//  ChangeDetailViewController.swift
//  ETong_ios
//
//  Created by 沈晓龙 on 16/11/7.
//  Copyright © 2016年 北京校酷网络科技有限公司. All rights reserved.
//

import UIKit

class ChangeDetailViewController: UIViewController, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, TZImagePickerControllerDelegate {
    
    var photoArray = NSMutableArray()
    var collectionV:UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        let button = UIButton.init(frame: CGRectMake(20, 30, 100, 30))
//        button.setImage(UIImage(named: "ic_tupian"), forState: UIControlState.Normal)
        button.setTitle("添加", forState: .Normal)
        button.addTarget(self, action: #selector(self.goToCamera1(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
//        addCollectionViewPicture()
    }

    func addCollectionViewPicture(){
        
        let flowl = UICollectionViewFlowLayout.init()
        //设置每一个item大小
        flowl.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowl.minimumInteritemSpacing = 5
        flowl.minimumLineSpacing = 5
        flowl.itemSize = CGSizeMake((self.view.frame.size.width - 20)/3.0, (self.view.frame.size.width - 20)/3.0)
        flowl.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        flowl.minimumInteritemSpacing = 10
        flowl.minimumLineSpacing = 10
        print(self.photoArray.count)
        self.collectionV?.removeFromSuperview()
        var height =  CGFloat(((self.photoArray.count-1)/3))*((self.view.frame.size.width - 20)/3.0+10)+((self.view.frame.size.width - 20)/3.0+10)
        if self.photoArray.count == 0 {
            height = 0
        }
        //创建集合视图
        self.collectionV = UICollectionView.init(frame: CGRectMake(0, 80, self.view.frame.size.width, height), collectionViewLayout: flowl)
        collectionV!.backgroundColor = UIColor.whiteColor()
        collectionV!.delegate = self
        collectionV!.dataSource = self
        //        collectionV?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "photo")
        collectionV!.registerNib(UINib(nibName: "PhotoCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "photo")
        self.view.addSubview(collectionV!)
//        self.headerView.frame.size.height = 250+(collectionV?.frame.size.height)!
//        self.mytableView.tableHeaderView = self.headerView
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.photoArray.count)
        if self.photoArray.count == 0 {
            return 0
        }else{
            
            return photoArray.count
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photo", forIndexPath: indexPath)as! PhotoCollectionViewCell
//        print(self.photoArray[indexPath.item] as? UIImage)
        if self.photoArray.count != 0 {
            cell.imgBtn.setBackgroundImage(self.photoArray[indexPath.item] as? UIImage, forState: UIControlState.Normal)
            
            //        cell.imgView.image = [UIImage (named: self.photoArray[indexPath.item])]
            let button = UIButton.init(frame: CGRectMake(cell.frame.size.width-18, 0, 20, 20))
            button.setImage(UIImage(named: "ic_shanchu-cha"), forState: UIControlState.Normal)
            button.tag = indexPath.row
            button.addTarget(self, action: #selector(self.deleteImage(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            cell.addSubview(button)
        }
        return cell
    }
    
    //删除照片
    func deleteImage(btn:UIButton){
        print(btn.tag)
        self.photoArray.removeObjectAtIndex(btn.tag)
//        self.photoArray.removeAtIndex(btn.tag)
        self.collectionV?.reloadData()
        print(self.photoArray.count)
        if self.photoArray.count == 0 {
            self.collectionV?.frame.size.height = 0
            self.photoArray.removeAllObjects()
            self.collectionV?.removeFromSuperview()
//            self.addCollectionViewPicture()
//            self.collectionV?.reloadData()
        }
        
    }
    
    func goToCamera1(btn:UIButton){
        let imagePickerVc = TZImagePickerController.init(maxImagesCount: 9, delegate:self)
        print("上传图片")
        print(btn.tag)
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePickerVc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [AnyObject]!, isSelectOriginalPhoto: Bool, infos: [[NSObject : AnyObject]]!) {
//        self.photoArray.removeAllObjects()
        for images in photos {
            photoArray.addObject(images)
        }
//        if photoArray.count == 0 {
        
            self.addCollectionViewPicture()
//        self.collectionV?.reloadData()
//        }
    }
    
    //上传图片的协议与代理方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage]as! UIImage
        self.photoArray.addObject(image)
        print(self.photoArray)
        self.addCollectionViewPicture()
        let data = UIImageJPEGRepresentation((info[UIImagePickerControllerEditedImage] as? UIImage)!, 0.1)!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateStr = dateFormatter.stringFromDate(NSDate())
        let imageName = "avatar" + dateStr + ETUserInfo.sharedETUserInfo().Id
        
//        ConnectModel.uploadWithImageName(imageName, imageData: data, URL: kUPLOAD_URL_HEAD) { [unowned self] (data) in
//            st_dispatch_async_main({
////                self.currentBtn?.setImage(image, forState: .Normal)
//                if !self.photoArray.containsObject(imageName+".png"){
//                    
////                    self.photoArray.addObject(imageName+".png")
//                }
//            })
//        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

}
