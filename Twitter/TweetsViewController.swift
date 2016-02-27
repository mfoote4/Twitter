//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Michaela Foote on 2/20/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource {

    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshedTimelineTweets", name: "refreshedTimelineTweets", object: nil)
        //TwitterClient.sharedInstance.getTweets()
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: {(tweets,
            error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        })
    }
    
    func refreshedTimelineTweets() {
        tableView.reloadData()
    }
    
    func onRefresh() {
        refreshedTimelineTweets()
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
       
        print(self.tweets?.count)
        if self.tweets != nil {
            return (self.tweets?.count)!
        } else {
            return 0
        }
        
        //return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as? TweetCell
        
    
       cell!.tweet = tweets![indexPath.row]
        
        return cell!
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "DetailView") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.tweet = tweet
        }
        else if(segue.identifier == "ComposeView"){
        
        }
        else if(segue.identifier == "ReplyView"){
            
        }
        else if(segue.identifier == "ProfileView"){
            
        }
        
    }
    

}
