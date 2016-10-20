//
//  PostTableViewController.swift
//  Pods
//
//  Created by Le Dinh on 19/10/16.
//
//

import UIKit

public class PostTableViewController: UITableViewController {
    var posts = [PostItem]()
    var titleHandler: ((Int)->())?
    override public func viewDidLoad() {
        super.viewDidLoad()
        let podBundle = NSBundle(path: NSBundle(forClass: PostTableViewController.self).pathForResource("SGSnackBar", ofType: "bundle")!)
        let nib = UINib(nibName: "PostCell", bundle:podBundle)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "postItem")
    }
    
    func titleTapping(sender: UITapGestureRecognizer) {
        postRead((sender.view?.tag)!)
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func postRead(index: Int){
        
        print("I'm reading post", index)
        titleHandler?(index)
    }

    // MARK: - Table view data source

    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    public func addHandler(function: (Int)->()){
        titleHandler = function
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("postItem", forIndexPath: indexPath) as! PostTableViewCell
        let titleTap = UITapGestureRecognizer(target: self, action: Selector("titleTapping:"))
        titleTap.numberOfTapsRequired = 1
        cell.myLabel.addGestureRecognizer(titleTap)
        cell.myLabel.userInteractionEnabled = true
        cell.myLabel.text = posts[indexPath.row].title
        cell.myLabel.tag = indexPath.row
        cell.addHandler(titleHandler)
        return cell
    }

//    public func loadPost(array: [PostItem]) {
//        posts = array
////        tableView.dataSource = array
//    }

    public func generatePostlist(myPost: [NSObject]) {
        posts = [PostItem]()
        for item in myPost {
            var p = PostItem()
            
            if let title = item.valueForKey("title") as? String {
                 p.title = title
            }
            posts.append(p)
        }
        tableView.reloadData()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
