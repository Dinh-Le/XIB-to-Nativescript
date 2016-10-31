//
//  PostTableViewCell.swift
//  Pods
//
//  Created by Le Dinh on 19/10/16.
//
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var post: UIView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editTap(sender: UIButton) {
        editTapping!(sender.tag)
    }
    
    var postReading: ((Int)->())?
    var editTapping: ((Int)->())?

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
}
