//
//  ViewController.swift
//  Demo-Socket-Swift
//
//  Created by Amit Tandel on 12/03/18.
//  Copyright © 2018 Amit Tandel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: NSNotification.Name(kNotificationRandomAdded), object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        let randNums = ATAppManager.sharedManager().getRecentRandomNumbers(3)
        print(randNums)
    }

}

