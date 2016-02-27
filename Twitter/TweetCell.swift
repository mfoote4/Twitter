//
//  TweetCell.swift
//  Twitter
//
//  Created by Michaela Foote on 2/20/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var profilepicView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            statusLabel.text = tweet.text
            profilepicView.setImageWithURL(NSURL(string:
                (tweet.user?.profileImageUrl)!)!)
            profilepicView.layer.cornerRadius = 9.0
            nameLabel.text = tweet.user?.name
            timeLabel.text = tweet.createdAtString
            favoriteLabel.text = String(tweet.favoriteCount!)
            retweetLabel.text = String(tweet.retweetCount!)
        }
}

    
    @IBAction func retweetButton(sender: AnyObject) {
        
       sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        retweetLabel.text = String(tweet.retweetCount!+1)
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        favoriteLabel.text = String(tweet.favoriteCount!+1)
    }
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
