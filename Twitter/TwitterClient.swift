//
//  TwitterClient.swift
//  Twitter
//
//  Created by Michaela Foote on 2/15/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "29nfj8UbiDHnWboJuPM23HV6H"
let twitterConsumerSecret = "U8m55PdDS9u4rpgNHoCsoZsT2ypOqA5s2gO7H7fOmFxJyklqat"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
                static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            // print("home timeline: \(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
        })

    }
    
    func userTimelineWithParams(params: NSDictionary? , completion: (tweets: [Tweet]?, error: NSError?) -> ()){
        GET("1.1/statuses/user_timeline.json?screen_name=adamyounglove", parameters: params, success: {
            (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error)")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterMichaela://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (Error: NSError!) -> Void in print("Failed to get request token")
        }

    }
    
  /*  func getTweets() {
        //Tweet.timelineTweets = nil
        TwitterClient.sharedInstance.GET(
            "1.1/statuses/home_timeline.json",
            parameters: nil,
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
               // Tweet.timelineTweets = tweets
                NSNotificationCenter.defaultCenter().postNotificationName("refreshedTimelineTweets", object: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to get current user")
            }
        )
    }*/

    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                //print("user: \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                    print("error getting current user")
                    self.loginCompletion!(user: nil, error: error)
            })
            
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
                
        }

    }
    
    func tweet(text: String) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/update.json",
            parameters: ["status": text],
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("posted tweet: \(text)")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to get current user")
                print(error)
            }
        )
    }
    
    func reply(text: String, id: Int) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/update.json",
            parameters: [
                "status": text,
                "in_reply_to_status_id": id
            ],
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("replied to tweet: \(text)")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed reply")
                print(error)
            }
        )
    }
    func favorite(id: Int) {
        TwitterClient.sharedInstance.POST(
            "1.1/favorites/create.json",
            parameters: ["id": id],
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("favorited tweet: \(id)")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to favorite")
                print(error)
            }
        )
    }
    func retweet(id: Int) {
        TwitterClient.sharedInstance.POST(
            "1.1/statuses/retweet/\(id).json",
            parameters: ["id": id],
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("retweeted tweet: \(id)")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to retweet")
                print(error)
            }
        )
    }
    
}
