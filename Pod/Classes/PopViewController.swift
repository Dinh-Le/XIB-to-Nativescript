//
//  PopViewController.swift
//  Pods
//
//  Created by Le Dinh on 03/11/16.
//
//

import UIKit

class PopViewController: UIViewController {

    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var viadeoView: UIView!
    @IBOutlet weak var wechatView: UIView!
    @IBOutlet weak var instagramView: UIView!
    @IBOutlet weak var copyLinkView: UIView!
    
    var socnetList: [String] = []
    var postIndex: Int!
    
    var shareTap: ((Int)->())?
    var copyLinkTap: ((Int)->())?
    var wechatTap: ((Int)->())?
    var instagramTap: ((Int)->())?
    var viadeoTap:((Int)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if socnetList.count == 0 {
            shareView.userInteractionEnabled = false
            for sub in shareView.subviews {
                var label: UILabel = sub as! UILabel
                label.textColor = UIColor.lightGrayColor()
            }
        }
        
        if socnetList.indexOf("viadeo") == nil {
            viadeoView.userInteractionEnabled = false
            for sub in viadeoView.subviews {
                var label: UILabel = sub as! UILabel
                label.textColor = UIColor.lightGrayColor()
            }
        }
        if socnetList.indexOf("wechat") == nil {
            wechatView.userInteractionEnabled = false
            for sub in wechatView.subviews {
                var label: UILabel = sub as! UILabel
                label.textColor = UIColor.lightGrayColor()
            }
        }
        if socnetList.indexOf("instagram") == nil {
            instagramView.userInteractionEnabled = false
            for sub in instagramView.subviews {
                var label: UILabel = sub as! UILabel
                label.textColor = UIColor.lightGrayColor()
            }
        }
        if socnetList.indexOf("generic") == nil {
            copyLinkView.userInteractionEnabled = false
            for sub in copyLinkView.subviews {
                var label: UILabel = sub as! UILabel
                label.textColor = UIColor.lightGrayColor()
            }
        }
        
        //Share view
        let shareViewTap = UITapGestureRecognizer(target: self, action: Selector("shareViewTapping:"))
        shareViewTap.numberOfTapsRequired = 1
        shareView.userInteractionEnabled = true
        shareView.addGestureRecognizer(shareViewTap)
        
        //Copy link
        let copyLinkViewTap = UITapGestureRecognizer(target: self, action: Selector("copyLinkViewTapping:"))
        copyLinkViewTap.numberOfTapsRequired = 1
        copyLinkView.userInteractionEnabled = true
        copyLinkView.addGestureRecognizer(copyLinkViewTap)
        
        //Wechat tap
        let wechatViewTap = UITapGestureRecognizer(target: self, action: Selector("wechatViewTapping:"))
        wechatViewTap.numberOfTapsRequired = 1
        wechatView.userInteractionEnabled = true
        wechatView.addGestureRecognizer(wechatViewTap)
        
        //Instagram tap
        let instagramViewTap = UITapGestureRecognizer(target: self, action: Selector("instagramViewTapping:"))
        instagramViewTap.numberOfTapsRequired = 1
        instagramView.userInteractionEnabled = true
        instagramView.addGestureRecognizer(instagramViewTap)
        
        //Viadeo tap
        let viadeoViewTap = UITapGestureRecognizer(target: self, action: Selector("viadeoViewTapping:"))
        viadeoViewTap.numberOfTapsRequired = 1
        viadeoView.userInteractionEnabled = true
        viadeoView.addGestureRecognizer(viadeoViewTap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareViewTapping(sender: UIView) {
        dismissViewControllerAnimated(false, completion: nil)
        shareTap?(postIndex)
    }
    
    func copyLinkViewTapping(sender: UIView) {
        dismissViewControllerAnimated(false, completion: nil)
        copyLinkTap?(postIndex)
    }
    
    func wechatViewTapping(sender: UIView) {
        dismissViewControllerAnimated(false, completion: nil)
        wechatTap?(postIndex)
    }
    
    func instagramViewTapping(sender: UIView) {
        dismissViewControllerAnimated(false, completion: nil)
        instagramTap?(postIndex)
    }
    
    func viadeoViewTapping(sender: UIView) {
        dismissViewControllerAnimated(false, completion: nil)
        viadeoTap?(postIndex)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
