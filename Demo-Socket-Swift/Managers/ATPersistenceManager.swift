//
//  ATPersistenceManager.swift
//  HeadyDemoSwift
//
//  Created by Amit Tandel on 01/03/18.
//  Copyright © 2018 Amit Tandel. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Model

final class RandomNumber: Object {
    @objc dynamic var number:Double = 0.0
    @objc dynamic var date:Date = Date()
}

class ATPersistenceManager
{
    private static var sharedManagerObject: ATPersistenceManager = {
        let sharedManagerObject = ATPersistenceManager()
        return sharedManagerObject
    }()
    
    class func sharedManager() -> ATPersistenceManager {
        return sharedManagerObject
    }
    func addRandomNumber(_ randomNumer:RandomNumber) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(randomNumer)
        }
    }
    func getRecentRandomNumbers(_ limit:Int) -> [RandomNumber] {
        let realm = try! Realm()
        var nums = Array(realm.objects(RandomNumber.self))
        if nums.count > limit {
            nums = Array(nums[nums.count-limit...nums.count-1])
        }
        return nums
    }
    func getLastRandomNumber() -> RandomNumber! {
        let nums = self.getRecentRandomNumbers(1)
        if nums.count > 0 {
            return nums[0]
        }
        return nil
    }
    func getLast2RandomNumbers() -> [RandomNumber] {
        return self.getRecentRandomNumbers(2)
    }
    
    func getNumsOfRandomNumbers() -> Int {
        let realm = try! Realm()
        let count = Array(realm.objects(RandomNumber.self)).count
        return count
    }
}
