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
    
    
    var tweet: Tweet! {
        didSet {
            statusLabel.text = tweet.text
            profilepicView.setImageWithURL(NSURL(string:
                (tweet.user?.profileImageUrl)!)!)
            nameLabel.text = tweet.user?.name
            timeLabel.text = tweet.createdAtString
            //retweetLabel.text = "Retweet"
    
            /*if (tweet?.retweetCount)! == true {
                retweetLabel.text = "retweet"
            }
            else {
                retweetLabel.hidden = true
        
      /*  if (tweet?.favoriteCount)! == true {
            favoriteLabel.text = "favorite"
            
        }
        else {
            favoriteLabel.hidden = true
        }*/
    }*/
  }
}

    
    @IBAction func retweetButton(sender: AnyObject) {
        
       sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
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
