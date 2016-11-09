//
//  ProposedTableViewCell.swift
//  Pods
//
//  Created by Le Dinh on 09/11/16.
//
//

import UIKit

class ProposedTableViewCell: UITableViewCell {
    @IBOutlet weak var post: UIView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var separateDot: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func editTap(sender: UIButton) {
        editTapping!(sender.tag)
    }
    
    @IBAction func approveTap(sender: UIButton) {
        print("Approve")
    }
    
    @IBAction func deleteTap(sender: UIButton) {
        print("Delete")
    }
    
    var postReading: ((Int)->())?
    var editTapping: ((Int)->())?
    var parentVC: UIViewController!
    var socnetList: [String]!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    public func addEditTap(function: ((Int)->())?){
        editTapping = function
    }
}
