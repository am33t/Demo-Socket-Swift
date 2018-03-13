//
//  ATAppManager.swift
//  Demo-Shop-Swift
//
//  Created by Amit Tandel on 06/03/18.
//  Copyright © 2018 Amit Tandel. All rights reserved.
//

import Foundation

public let kNotificationRandomAdded = "kNotificationRandomAdded"
public let kNotificationRandomReapeadReceived = "kNotificationRandomReapeadReceived"
class ATAppManager
{
    private static var sharedManagerObject: ATAppManager = {
        let sharedManagerObject = ATAppManager()
        return sharedManagerObject
    }()
    
    class func sharedManager() -> ATAppManager {
        return sharedManagerObject
    }
    private var isRecordingRandomNumbers = false
    func startRecordingRandomNumbers() {
        if self.isRecordingRandomNumbers == true {
            return
        }
        self.isRecordingRandomNumbers = true
        ATSocketManager.sharedManager().startRecevingRandomNumbers { (receivedNumber, success) in
            let randomNumber = RandomNumber()
            randomNumber.number = receivedNumber
            randomNumber.date = Date()
            ATPersistenceManager.sharedManager().addRandomNumber(randomNumber)
            NotificationCenter.default.post(name: NSNotification.Name(kNotificationRandomAdded), object: randomNumber)
            self.checkForRepeatedRandom()
        }
    }
    private func checkForRepeatedRandom() {
        let nums = ATPersistenceManager.sharedManager().getLast2RandomNumbers()
        if nums.count > 1 {
            let num1 = nums[0]
            let num2 = nums[1]
            if num1.number == num2.number {
                NotificationCenter.default.post(name: NSNotification.Name(kNotificationRandomReapeadReceived), object: num2)
            }
        }
    }
    func getRecentRandomNumbers(_ limit:Int) -> [RandomNumber] {
      return ATPersistenceManager.sharedManager().getRecentRandomNumbers(limit)
    }
    func getLastRandomNumber() -> RandomNumber! {
        return ATPersistenceManager.sharedManager().getLastRandomNumber()
    }
    func getNumsOfRandomNumbers() -> Int {
        return ATPersistenceManager.sharedManager().getNumsOfRandomNumbers()
    }
}
