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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let shareViewTap = UITapGestureRecognizer(target: self, action: Selector("shareViewTapping:"))
        shareViewTap.numberOfTapsRequired = 1
        self.shareView.userInteractionEnabled = true
        self.shareView.addGestureRecognizer(shareViewTap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareViewTapping(sender: UIView) {
        self.dismissViewControllerAnimated(false, completion: nil)
        shareTap?(postIndex)
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
