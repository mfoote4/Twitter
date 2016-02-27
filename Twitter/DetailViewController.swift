//
//  DetailViewController.swift
//  Twitter
//
//  Created by Michaela Foote on 2/25/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var profilePictureLabel: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
     var tweet: Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.text = tweet.text
        nameLabel.text = tweet.user?.name
        profilePictureLabel.setImageWithURL(NSURL(string:
            (tweet.user?.profileImageUrl)!)!)
        profilePictureLabel.layer.cornerRadius = 9.0
        favoriteLabel.text = String(tweet.favoriteCount!)
        retweetLabel.text = String(tweet.retweetCount!)
        
    }

    @IBAction func retweetButton(sender: AnyObject) {
        sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        retweetLabel.text = String(tweet.retweetCount!+1)
    }

    @IBAction func favoriteButton(sender: AnyObject) {
        sender.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        favoriteLabel.text = String(tweet.favoriteCount!+1)
    }
    
    @IBAction func replyButton(sender: AnyObject) {
    }
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
