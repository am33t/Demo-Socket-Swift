//
//  ATRandomChartVC.swift
//  Demo-Shop-Swift
//
//  Created by Amit Tandel on 13/03/18.
//  Copyright © 2018 Amit Tandel. All rights reserved.
//

import UIKit
import SwiftChart

class ATRandomChartVC: UIViewController {

    @IBOutlet var lblNumberOfRandoms:UILabel!
    @IBOutlet var vwChartContainer:UIView!
    @IBOutlet var chart:Chart!
    
    var dataPoints = [String]()
    var values = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.refreshChart()
        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification(notification:)), name: NSNotification.Name(kNotificationRandomAdded), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        let randomNumber = ATAppManager.sharedManager().getLastRandomNumber()
        let randomNumbersCount = ATAppManager.sharedManager().getNumsOfRandomNumbers()
        if randomNumber != nil {
            self.lblNumberOfRandoms.text = "Last Number: \(Int(randomNumber!.number))\nTotal Numbers Stored: \(randomNumbersCount)"
            self.refreshChart()
        }
    }
 

    func refreshChart() {
        let randomNumbers = ATAppManager.sharedManager().getRecentRandomNumbers(10)
        var data:[Double] = []
        for i in (0..<randomNumbers.count)
        {
            let randomNumber = randomNumbers[i]
            data.append(randomNumber.number)
        }
        let series = ChartSeries(data)
        series.colors = (
            above: ChartColors.blueColor(),
            below: UIColor.white,
            zeroLevel: 7
        )
        series.area = true
        chart.removeAllSeries()
        chart.add(series)
        
        // Set minimum and maximum values for y-axis
        chart.minY = 0
        chart.maxY = 10
        chart.lineWidth = 3
        chart.highlightLineColor = UIColor.red
        chart.labelColor = UIColor.white
        chart.showXLabelsAndGrid = true
    }
    func setUpUI()
    {
        self.view.backgroundColor = UIColor(white: 0.1, alpha: 1)
        self.vwChartContainer.backgroundColor = UIColor(white: 0.1, alpha: 1)
        self.lblNumberOfRandoms.text = ""
        self.lblNumberOfRandoms.textColor = UIColor.white
        
        let randomNumber = ATAppManager.sharedManager().getLastRandomNumber()
        let randomNumbersCount = ATAppManager.sharedManager().getNumsOfRandomNumbers()
        if randomNumber != nil {
            self.lblNumberOfRandoms.text = "Last Number: \(Int(randomNumber!.number))\nTotal Numbers Stored: \(randomNumbersCount)"
        }
    }
    
    
}
