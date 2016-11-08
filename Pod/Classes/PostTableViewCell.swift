//
//  PostTableViewCell.swift
//  Pods
//
//  Created by Le Dinh on 19/10/16.
//
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    var postReading: ((Int)->())?
    var editTapping: ((Int)->())?
    var commentTapping: ((Int, Bool)->())?
    var showPopover: ((UIButton)->())?
    var parentVC: UIViewController!
    @IBOutlet weak var post: UIView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var separateDot: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func shareTap(sender: UIButton) {
        var popBundle = NSBundle(path: NSBundle(forClass: PopViewController.self).pathForResource("SGSnackBar", ofType: "bundle")!)
        let filterVC =  PopViewController(nibName: "PopView", bundle: popBundle)
        
        let screen = UIScreen.mainScreen().bounds.width
        filterVC.preferredContentSize = CGSizeMake(screen, 280)
        filterVC.modalPresentationStyle = .Popover
        let popoverPresentationViewController = filterVC.popoverPresentationController!
        popoverPresentationViewController.permittedArrowDirections = [.Up, .Down]
        popoverPresentationViewController.delegate = parentVC as! UIPopoverPresentationControllerDelegate
        popoverPresentationViewController.sourceView = self;
        popoverPresentationViewController.sourceRect = sender.frame
        parentVC.presentViewController(filterVC, animated: true, completion: nil)
    }
    
    @IBAction func editTap(sender: UIButton) {
        editTapping!(sender.tag)
    }
    
    @IBAction func commentTap(sender: UIButton) {
        commentTapping!(sender.tag, true)
    }

    private func myIndex() -> Int {
        return (self.superview?.superview as! UITableView).indexPathForCell(self)!.row
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func addHandler(function: ((Int)->())?){
        postReading = function
    }
    
    public func addEditTap(function: ((Int)->())?){
        editTapping = function
    }
    
    public func addCommentTapping(function: ((Int, Bool)->())?){
        commentTapping = function
    }
}
