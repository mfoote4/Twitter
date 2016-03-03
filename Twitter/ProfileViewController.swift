//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Michaela Foote on 2/26/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profilepicLarge: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var nameHead: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var handleLabel: UILabel!
    
    
    var user: User?
    var tweets: [Tweet]?
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        TwitterClient.sharedInstance.userTimelineWithParams(nil, completion: {(tweets,
            error) -> () in
            self.tweets = tweets
            
            for tweet in (tweets)! {
                
                self.user = tweet.user
            }
            
            self.tweetsLabel.text = String(self.user!.numberTweets!)
            self.followingLabel.text = String(self.user!.numberFollowing!)
            self.followersLabel.text = String(self.user!.numberFollowers!)
            self.handleLabel.text = "@" + String(self.user!.screenname!)
            self.nameHead.text = String(self.user!.name!)
            self.profilepicLarge.setImageWithURL(NSURL(string: self.user!.profileImageUrl!)!)
            self.backgroundImage.setImageWithURL(NSURL(string: self.user!.profileImageBackgroundUrl!)!)
            
            
            self.tableView.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.tweets != nil {
            return (self.tweets?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as? TweetCell
        
        cell?.tweet = tweets![indexPath.row]
        
        
        return cell!
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
