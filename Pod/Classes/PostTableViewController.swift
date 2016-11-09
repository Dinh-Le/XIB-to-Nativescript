//
//  PostTableViewController.swift
//  Pods
//
//  Created by Le Dinh on 19/10/16.
//
//

import UIKit

public class PostTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    var postlist = [PostItem]()
    var postReading: ((Int)->())?
    var loadMore: (()->())?
    var editTap: ((Int)->())?
    var commentTap: ((Int, Bool)->())?
    var shareTap: ((Int)->())?
    var approveTap: ((Int)->())?
    var deleteTap: ((Int)->())?
    var isAdmin: Bool = false
    var currentTab: String = "published"
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame.size.width = 0
        let podBundle = NSBundle(path: NSBundle(forClass: PostTableViewController.self).pathForResource("SGSnackBar", ofType: "bundle")!)
        let publishedNib = UINib(nibName: "PostCell", bundle:podBundle)
        let proposedNib = UINib(nibName: "ProposedCell", bundle: podBundle)
        tableView.registerNib(publishedNib, forCellReuseIdentifier: "publishedItem")
        tableView.registerNib(proposedNib, forCellReuseIdentifier: "proposedItem")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 88.0;
        self.tableView.separatorColor = UIColor.whiteColor()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postlist.count
    }

    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = postlist[indexPath.row]
        
        switch currentTab {
            case "published":
                let cell = self.tableView.dequeueReusableCellWithIdentifier("publishedItem", forIndexPath: indexPath) as! PostTableViewCell
                let postTap = UITapGestureRecognizer(target: self, action: Selector("postTapping:"))
                postTap.numberOfTapsRequired = 1
                cell.parentVC = self
                cell.addHandler(postReading)
                cell.socnetList = item.socnetList
                
                //Post
                cell.post.userInteractionEnabled = true
                cell.post.tag = indexPath.row
                cell.post.addGestureRecognizer(postTap)
                
                //Image
                if item.image == "" {
                    let noImg = UIImage(named: "no_image.jpg")
                    cell.postImage.image = noImg
                }
                else {
                    if let url = NSURL(string: item.image) {
                        if let data = NSData(contentsOfURL: url) {
                            if let i = UIImage(data: data) {
                                cell.postImage.image = i
                            }
                        }
                    }
                }
                cell.postImage.userInteractionEnabled = true
                cell.postImage.clipsToBounds = true
                
                //Title
                cell.title.userInteractionEnabled = true
                cell.title.text = item.title
                
                //Body
                cell.body.text = item.body
                cell.body.userInteractionEnabled = true
                
                //Date
                cell.date.text = item.date as? String
                
                //Edit button
                cell.editButton.tag = indexPath.row
                cell.addEditTap(editTap)
                if self.isAdmin == false {
                    cell.editButton.hidden = true;
                }
                
                //CommentCount label
                if item.commentEnabled == true {
                    cell.commentCount.text = "\(item.commentCount) comments"
                    let commentCountTap = UITapGestureRecognizer(target: self, action: Selector("commentTapping:"))
                    commentCountTap.numberOfTapsRequired = 1
                    cell.commentCount.userInteractionEnabled = true
                    cell.commentCount.addGestureRecognizer(commentCountTap)
                    cell.commentCount.tag = indexPath.row
                }
                else {
                    cell.commentCount.hidden = true
                    cell.separateDot.hidden = true
                    cell.comment.enabled = false
                    cell.comment.setTitleColor(UIColor.lightGrayColor().colorWithAlphaComponent(0.7), forState: UIControlState.Normal)
                }
                
                //Comment button
                cell.addCommentTapping(commentTap)
                cell.comment.tag = indexPath.row
                    
                //Share button
                cell.shareButton.tag = indexPath.row
                cell.shareTap = shareTap
                
                return cell
            
            case "proposed":
                let cell = self.tableView.dequeueReusableCellWithIdentifier("proposedItem", forIndexPath: indexPath) as! ProposedTableViewCell
            
                let postTap = UITapGestureRecognizer(target: self, action: Selector("postTapping:"))
                postTap.numberOfTapsRequired = 1
                cell.parentVC = self
                cell.socnetList = item.socnetList
                
                //Post
                cell.post.userInteractionEnabled = true
                cell.post.tag = indexPath.row
                cell.post.addGestureRecognizer(postTap)
                
                //Image
                if item.image == "" {
                    let noImg = UIImage(named: "no_image.jpg")
                    cell.postImage.image = noImg
                }
                else {
                    if let url = NSURL(string: item.image) {
                        if let data = NSData(contentsOfURL: url) {
                            if let i = UIImage(data: data) {
                                cell.postImage.image = i
                            }
                        }
                    }
                }
                cell.postImage.userInteractionEnabled = true
                cell.postImage.clipsToBounds = true
                
                //Title
                cell.title.userInteractionEnabled = true
                cell.title.text = item.title
                
                //Body
                cell.body.text = item.body
                cell.body.userInteractionEnabled = true
                
                //Date
                cell.date.text = item.date as? String
                
                //Edit button
                cell.editButton.tag = indexPath.row
                cell.addEditTap(editTap)
                if self.isAdmin == false {
                    cell.editButton.hidden = true;
                }
                
                //CommentCount label
                if item.commentEnabled == true {
                    cell.commentCount.text = "\(item.commentCount) comments"
                    let commentCountTap = UITapGestureRecognizer(target: self, action: Selector("commentTapping:"))
                    commentCountTap.numberOfTapsRequired = 1
                    cell.commentCount.userInteractionEnabled = true
                    cell.commentCount.addGestureRecognizer(commentCountTap)
                    cell.commentCount.tag = indexPath.row
                }
                else {
                    cell.commentCount.hidden = true
                    cell.separateDot.hidden = true
                }
                
                //Approve button
                cell.approveButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
                cell.approveButton.tag = indexPath.row
                cell.approveTapping = approveTap
                
                //Delete button
                cell.deleteButton.tag = indexPath.row
                cell.deleteTapping = deleteTap
                                
                return cell
            default:
                print("Default case defining cell")
                let cell: UITableViewCell = UITableViewCell()
                return cell
        }
    }
    
    override public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastRow = postlist.count - 1
        if indexPath.row == lastRow {
            loadMore?()
        }
    }
    
    func postTapping(sender: UITapGestureRecognizer) {
        postReading?((sender.view?.tag)!)
    }
    
    func commentTapping(sender: UITapGestureRecognizer) {
        commentTap?((sender.view?.tag)!, false)
    }
    
    public func addHandler(function: (Int)->()){
        postReading = function
    }
    
    public func addLoadMore(function: ()->()){
        loadMore = function
    }
    
    public func addEditTap(function: (Int)->()) {
        editTap = function
    }
    
    public func addCommentTap(function:(Int, Bool)->()){
        commentTap = function
    }
    
    public func addShareTap(function:(Int) -> ()) {
        shareTap = function
    }
    
    public func addApproveTap(function: (Int)->()) {
        approveTap = function
    }
    
    public func addDeleteTap(function: (Int)->()) {
        deleteTap = function
    }

    public func generatePostlist(posts: [NSObject]) {
        postlist = [PostItem]()
        for item in posts {
            var p = PostItem()
            
            if let title = item.valueForKey("title") as? String {
                 p.title = title
            }
            
            if let imageUrl = item.valueForKey("imageUrl") as? String {
                p.image = imageUrl
            }
            
            if let body = item.valueForKey("body") as? String {
                p.body = body
            }
            
            if let date = item.valueForKey("postDate") as? String {
                p.date = date
            } else {
                p.date = ""
            }
            
            if let cmtCount = item.valueForKey("commentCount") as? Int {
                p.commentCount = cmtCount
            }
            
            if let isCommentEnabled = item.valueForKey("commentEnabled") as? Bool {
                p.commentEnabled = isCommentEnabled
            }
            
            if let socnetList = item.valueForKey("socnetList") as? [String] {
                p.socnetList = socnetList
            }
            postlist.append(p)
        }
        tableView.reloadData()
    }
    
    public func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    public func refresh() {
        postlist = [PostItem]()
    }
    
    public func setAdmin(value: Bool) {
        self.isAdmin = value
    }
    
    public func setTab(tab: String) {
        currentTab = tab.lowercaseString
    }
}
