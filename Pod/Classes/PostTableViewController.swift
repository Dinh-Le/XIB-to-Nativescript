//
//  PostTableViewController.swift
//  Pods
//
//  Created by Le Dinh on 19/10/16.
//
//

import UIKit

public class PostTableViewController: UITableViewController {
    var postlist = [PostItem]()
    var titleHandler: ((Int)->())?
    var loadMore: (()->())?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame.size.width = 0
        let podBundle = NSBundle(path: NSBundle(forClass: PostTableViewController.self).pathForResource("SGSnackBar", ofType: "bundle")!)
        let nib = UINib(nibName: "PostCell", bundle:podBundle)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "postItem")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 88.0;
    }
    
    func titleTapping(sender: UITapGestureRecognizer) {
        titleHandler?((sender.view?.tag)!)
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
    
    public func addHandler(function: (Int)->()){
        titleHandler = function
    }
    
    public func addLoadMore(function: ()->()){
        loadMore = function
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postlist.count
    }

    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = postlist[indexPath.row]
        let cell = self.tableView.dequeueReusableCellWithIdentifier("postItem", forIndexPath: indexPath) as! PostTableViewCell
        let titleTap = UITapGestureRecognizer(target: self, action: Selector("titleTapping:"))
        titleTap.numberOfTapsRequired = 1
        cell.myLabel.addGestureRecognizer(titleTap)
        cell.myLabel.userInteractionEnabled = true
        cell.myLabel.text = item.title
        cell.myLabel.tag = indexPath.row
        
        //Body
        cell.body.text = item.body
        
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
        cell.postImage.clipsToBounds = true

        cell.addHandler(titleHandler)
//        cell.addLoadMore(loadMore)
        
        if indexPath.row == postlist.count - 3 {
            loadMore?()
        }
        return cell
    }

    public func generatePostlist(posts: [NSObject]) {
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
            
            postlist.append(p)
        }
        tableView.reloadData()
    }
    
    public func refresh() {
        postlist = [PostItem]()
    }
//    public func loadMore() {
//    }
}
