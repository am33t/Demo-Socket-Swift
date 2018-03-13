//
//  APIManager.swift
//  Demo-Shop-Swift
//
//  Created by Amit Tandel on 06/03/18.
//  Copyright © 2018 Amit Tandel. All rights reserved.
//

import Foundation
import SocketIO

class ATSocketManager
{
    private static var sharedManagerObject: ATSocketManager = {
        let sharedManagerObject = ATSocketManager()
        return sharedManagerObject
    }()

    class func sharedManager() -> ATSocketManager {
        return sharedManagerObject
    }
    
    let manager = SocketManager(socketURL: URL(string: "http://ios-test.us-east-1.elasticbeanstalk.com/")!, config: [.log(false), .compress])
    
    func startRecevingRandomNumbers(completion: @escaping(_ result: Double,_ success: Bool)->()) {
        let socket = manager.socket(forNamespace: "/random")
        socket.on(clientEvent: .connect) {data, ack in
            print("Socket Connected")
        }
        socket.on("capture") {data, ack in
            guard let cur = data[0] as? Double else { return }
            completion(cur,true)
        }
        socket.connect()
    }
}
