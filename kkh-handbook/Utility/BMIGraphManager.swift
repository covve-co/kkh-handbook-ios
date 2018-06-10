//
//  BMIGraphManager.swift
//  Handbook
//
//  Created by Ravern on 15/6/16.
//  Copyright © 2016 SST Inc. All rights reserved.
//

import UIKit

class BMIGraphManager: NSObject {
    
    var age: Int = 0
    var isMale: Bool = false
    var bmi: Float = 0
    
    enum Status: Int {
        case `nil` = 0;
        case severelyUnderweight = 1;
        case underweight = 2;
        case acceptable = 3;
        case overweight = 4;
        case severelyOverweight = 5;
    }
    
    //data
    let ages1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
    let percentilesMale1 = [
        [14.6, 13.4, 13.2, 13.0, 12.9, 13.0, 13.1, 13.3, 13.5, 13.9, 14.2, 14.5, 14.8, 15.1, 15.4, 15.7, 16.0, 16.2],
        [15.2, 14.4, 13.7, 13.4, 13.0, 13.2, 13.3, 13.5, 13.7, 14.2, 14.5, 14.8, 15.1, 15.4, 15.8, 16.1, 16.4, 16.6],
        [18.8, 17.5, 17.4, 17.5, 17.9, 18.9, 20.0, 21.1, 21.9, 22.7, 23.7, 24.4, 25.0, 25.6, 26.2, 26.6, 27.1, 27.5],
        [19.8, 18.8, 18.6, 19.0, 20.0, 21.5, 23.0, 24.5, 26.0, 27.3, 28.4, 29.2, 30.0, 30.8, 31.3, 31.8, 32.2, 32.4]
    ]
    let percentilesFemale1 = [
        [14.0, 13.2, 12.8, 12.6, 12.6, 12.8, 13.0, 13.2, 13.7, 14.0, 14.5, 14.8, 15.2, 15.6, 16.0, 16.2, 16.4, 16.6],
        [14.8, 14.0, 13.3, 13.1, 13.0, 13.0, 13.2, 13.6, 14.0, 14.3, 14.8, 15.2, 15.6, 16.0, 16.3, 16.7, 16.9, 17.0],
        [18.1, 17.2, 17.1, 17.2, 17.3, 19.0, 20.0, 21.0, 22.0, 23.0, 23.8, 24.6, 25.3, 26.0, 26.5, 26.9, 27.2, 27.4],
        [19.0, 18.5, 18.6, 18.8, 19.3, 21.5, 22.9, 24.3, 25.7, 27.1, 28.3, 29.2, 30.1, 30.8, 31.3, 31.7, 32.0, 32.3]
    ]

    init(age: Int, bmi: Float, isMale: Bool) {
        super.init()
        
        self.age = age
        self.bmi = bmi
        self.isMale = isMale
    }
    
    func range() -> Int {
        if age >= 18 {
            return 0
        }
        else{
            var data = [[Double]]()
            if isMale {
                data = percentilesMale1
            } else {
                data = percentilesFemale1
            }
            
            var status: Status! = nil
            let index = ages1.index(of: age)!
            for i in 0 ..< data.count {
                if Double(bmi) < data[i][index] {
                    status = Status(rawValue: i + 1)
                    break
                }
            }
            if status == nil {
                status = .severelyOverweight
            }
            
            return status.rawValue
        }
    }
    
//    func graph() -> UIView! {
//        let lineChartView = LineChartView()
//        
//        let ages1 = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
//        let percentilesMale1 = [
//            [13.0, 13.1, 13.3, 13.5, 13.9, 14.2, 14.5, 14.8, 15.1, 15.4, 15.7, 16.0, 16.2],
//            [13.2, 13.3, 13.5, 13.7, 14.2, 14.5, 14.8, 15.1, 15.4, 15.8, 16.1, 16.4, 16.6],
//            [13.6, 14.0, 14.2, 14.5, 14.7, 15.3, 15.7, 16.0, 16.2, 16.5, 17.0, 17.2, 17.5],
//            [14.3, 14.8, 15.2, 15.6, 16.0, 16.4, 16.8, 17.1, 17.6, 18.0, 18.4, 18.7, 19.0],
//            [15.8, 16.0, 16.5, 17.0, 17.7, 18.1, 18.8, 19.1, 19.5, 20.0, 20.2, 20.7, 21.0],
//            [17.0, 17.8, 18.5, 19.1, 19.9, 20.5, 21.1, 21.6, 22.1, 22.6, 23.1, 23.5, 23.9],
//            [18.2, 19.0, 19.8, 20.6, 21.4, 22.1, 22.9, 23.5, 24.0, 24.5, 25.0, 25.5, 26.0],
//            [18.9, 20.0, 21.1, 21.9, 22.7, 23.7, 24.4, 25.0, 25.6, 26.2, 26.6, 27.1, 27.5],
//            [20.5, 21.6, 23.0, 24.0, 25.2, 26.3, 27.1, 27.7, 28.4, 29.0, 29.6, 29.8, 30.2],
//            [21.5, 23.0, 24.5, 26.0, 27.3, 28.4, 29.2, 30.0, 30.8, 31.3, 31.8, 32.2, 32.4]
//        ]
////        let percentilesMale1 = [
////            [12.8, 13.0, 13.2, 13.7, 14.0, 14.5, 14.8, 15.2, 15.6, 16.0, 16.2, 16.4, 16.6],
////            [13.0, 13.2, 13.6, 14.0, 14.3, 14.8, 15.2, 15.6, 16.0, 16.3, 16.7, 16.9, 17.0],
////            [13.5, 14.0, 14.2, 14.6, 15.0, 15.4, 16.0, 16.2, 16.7, 17.0, 17.3, 17.6, 17.9],
////            [14.5, 14.9, 15.2, 15.7, 16.2, 16.8, 17.2, 17.6, 18.1, 18.5, 18.7, 19.0, 19.2],
////            [15.7, 16.2, 16.8, 17.3, 17.9, 18.5, 19.1, 19.6, 20.0, 20.5, 20.8, 21.1, 21.4],
////            [17.2, 17.9, 18.6, 19.4, 20.1, 20.9, 21.6, 22.1, 22.6, 23.1, 23.5, 23.8, 24.1],
////            [18.2, 19.0, 19.9, 20.8, 21.7, 22.5, 23.2, 23.9, 24.5, 25.0, 25.3, 25.7, 26.0],
////            [19.0, 20.0, 21.0, 22.0, 23.0, 23.8, 24.6, 25.3, 26.0, 26.5, 26.9, 27.2, 27.4],
////            [20.5, 21.5, 22.9, 24.1, 25.2, 26.4, 27.2, 28.0, 28.7, 29.2, 29.5, 29.9, 30.1],
////            [21.5, 22.9, 24.3, 25.7, 27.1, 28.3, 29.2, 30.1, 30.8, 31.3, 31.7, 32.0, 32.3]
////        ]
//        
//        var percentileValues = [[ChartDataEntry]]()
//        var percentileData = [LineChartDataSet]()
//        for i in 0 ..< percentilesMale1.count {
//            percentileValues.append([ChartDataEntry]())
//            for j in 0 ..< ages1.count {
//                percentileValues[i].append(ChartDataEntry(value: percentilesMale1[i][j], xIndex: j))
//            }
//            percentileData.append(LineChartDataSet(yVals: percentileValues[i], label: "Percentile \(i) Values"))
//            percentileData[i].drawCirclesEnabled = false
//            percentileData[i].drawValuesEnabled = false
//        }
//        
//        let allData = LineChartData(xVals: ages1, dataSets: percentileData)
//        
//        lineChartView.data = allData
//        lineChartView.leftAxis.drawGridLinesEnabled = false
//        lineChartView.leftAxis.labelTextColor = UIColor.whiteColor()
//        lineChartView.leftAxis.axisLineColor = UIColor.whiteColor()
//        lineChartView.rightAxis.drawGridLinesEnabled = false
//        lineChartView.rightAxis.labelTextColor = UIColor.whiteColor()
//        lineChartView.rightAxis.axisLineColor = UIColor.whiteColor()
//        lineChartView.xAxis.drawGridLinesEnabled = false
//        lineChartView.xAxis.labelTextColor = UIColor.whiteColor()
//        lineChartView.xAxis.axisLineColor = UIColor.whiteColor()
//        
//        
//        return lineChartView
//    }
}
