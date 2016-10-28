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
    var postReading: ((Int)->())?
    var loadMore: (()->())?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame.size.width = 0
        let podBundle = NSBundle(path: NSBundle(forClass: PostTableViewController.self).pathForResource("SGSnackBar", ofType: "bundle")!)
        let nib = UINib(nibName: "PostCell", bundle:podBundle)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "postItem")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 88.0;
        self.tableView.separatorColor = UIColor.whiteColor()
    }
    
    func postTapping(sender: UITapGestureRecognizer) {
        postReading?((sender.view?.tag)!)
    }
    
    func dismeTapping(sender: UITapGestureRecognizer) {
        print("Dis me")
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
        postReading = function
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
        let postTap = UITapGestureRecognizer(target: self, action: Selector("postTapping:"))
        postTap.numberOfTapsRequired = 1
        
        let dismeTap = UITapGestureRecognizer(target: self, action: Selector("dismeTapping:"))
        
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
        cell.postImage.addGestureRecognizer(dismeTap)
        cell.postImage.tag = indexPath.row
        
        //Title
        cell.postImage.clipsToBounds = true
//        cell.myLabel.addGestureRecognizer(postTap)
        cell.title.userInteractionEnabled = true
        cell.title.text = item.title
        cell.title.tag = indexPath.row
        
        //Body
        cell.body.text = item.body
        cell.body.tag = indexPath.row
        cell.body.userInteractionEnabled = true
//        cell.body.addGestureRecognizer(postTap)
        
        //Date
        cell.date.text = item.date as? String

        cell.addHandler(postReading)
        
        return cell
    }
    
    override public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastRow = postlist.count - 1
        if indexPath.row == lastRow {
            loadMore?()
        }
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
