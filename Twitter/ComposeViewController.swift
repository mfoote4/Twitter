//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Michaela Foote on 2/26/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
         textView.resignFirstResponder()
       
        // Do any additional setup after loading the view.
    }
    
    
   
    @IBAction func onTweet(sender: AnyObject) {
            TwitterClient.sharedInstance.tweet(self.textView.text!)
            
        
    }

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
