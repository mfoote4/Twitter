//
//  ReplyViewController.swift
//  Twitter
//
//  Created by Michaela Foote on 2/26/16.
//  Copyright © 2016 Michaela Foote. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {

    @IBOutlet weak var replyText: UITextView!
    var id: Int?
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        replyText.text = "@" + username!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onReply(sender: AnyObject) {
    
        self.navigationController?.popViewControllerAnimated(true)
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
