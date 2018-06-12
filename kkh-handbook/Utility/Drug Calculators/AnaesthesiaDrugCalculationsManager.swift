//
//  CalculationsManager.swift
//  Handbook
//
//  Created by Ravern on 9/6/16.
//  Copyright © 2016 SST Inc. All rights reserved.
//

import UIKit
import MessageUI

final class AnaesthesiaDrugCalculationsManager: NSObject, MFMailComposeViewControllerDelegate, DrugManager {
    
    var weight: Int = -1
    var emailData: String = ""

    let firstIndex = 7
    let multipliers = [
        
        
        
        
        
        
        7: 50,
        
        9: 6,
        10: 3,
        11: 5,
        
        13: 0.5,
        14: 0.2,
        15: 0.1,
        16: 0.2,
        
        18: 2,
        19: 4,
        20: 2,
        
        
        
        
        25: 0.25,
        26: 2.5,
        
        
        
        30: 4,
        
        32: 2,
        33: 5,
        
        35: 2,
        
        37: 0.2,
        
        
        
        41: 2,
        42: 4,
        
        44: 0.5,
        
        46: 0.6,
        
        
        
        50: 20,
        51: 50,
        
        53: 2
//        3 : 50,
//        4 : 50,
//        5: 300,
//        6: 3,
//        7: 10,
//        8: 10,
//        9: 0.1,
//        10: 0.02,
//        11: 1,
//        12: 0.2,
//        13: 50,
//        14: 1,
//        
//        16: 5,
//        17: 15,
//        18: 0.1,
//        19: 0.2,
//        
//        21: 0.5,
//        22: 1,
//        23: 4,
//        
//        25: 0.3,
//        26: 3,
//        
//        28: 30,
//        29: 15,
//        30: 1,
//        31: 3,
//        
//        33: 15,
//        
//        35: 50,
//        
//        
//        38: 1,
//        
//        40: 10,
//        
//        42: 3,
//        43: 250,
//        44: 25
    ]
    var dataLines: [String]!
    
    init(weight: Int) {
        super.init()
        
        self.weight = weight
        
        if let path = Bundle.main.path(forResource: "AnaesthesiaDrugList", ofType: "csv") {
            do {
                let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                dataLines = data.components(separatedBy: CharacterSet.newlines)
                for dataLine in dataLines {
                    if dataLine == "" {
                        dataLines.remove(at: dataLines.index(of: dataLine)!)
                    }
                }
                dataLines[2] = dataLines[2].replacingOccurrences(of: "XX", with: "\(weight)")
                for i in 3 ..< dataLines.count {
                    if multipliers[i + 1] != nil {
                        dataLines[i] = dataLines[i].replacingOccurrences(of: "XX", with: truncateIfWhole(Double(weight) * multipliers[i + 1]!))
                    }
                }
                
                printLines(dataLines)
                for i in 0 ..< dataLines.count {
                    emailData = emailData + "\(dataLines[i])\n"
                }
            } catch {
                
            }
        }
    }
    
    func sendEmail(_ sender: UIViewController) {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = self
        vc.setSubject("Drug Table")
        vc.setMessageBody("Attached is the list of drugs for patient of \(weight)kg weight.", isHTML: false)
        vc.addAttachmentData(emailData.data(using: String.Encoding.utf8)!, mimeType: "text/csv", fileName: "Drug_table.csv")
        
        if !MFMailComposeViewController.canSendMail(){}
        else{
            sender.present(vc, animated: true) {
                
            }}
    }
    
    func getData() -> Data? {
        return emailData.data(using: String.Encoding.utf8)!
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: {
            
        })
    }
    
    typealias Route = [String : String]
    typealias Drug = [String : Route]
    
    func getDrugList() -> [String : Drug]! {
        var nameList: [String : Drug]! = [:]
        for i in firstIndex ..< dataLines.count {
            let dataLine = dataLines[i]
            if !dataLine.hasPrefix(",") {
                let lineComponents = dataLine.components(separatedBy: ",")
                if lineComponents[3].isNumber() {
                    // is drug
                    if nameList[lineComponents[0]] == nil {
                        nameList[lineComponents[0]] = [:]
                    }
                    nameList[lineComponents[0]]?[lineComponents[2]] = [:]
                    nameList[lineComponents[0]]?[lineComponents[2]]?["DOSE/KG"] = lineComponents[3]
                    nameList[lineComponents[0]]?[lineComponents[2]]?["AMOUNT"] = "\(((lineComponents[3] as NSString).integerValue * weight))"
                    nameList[lineComponents[0]]?[lineComponents[2]]?["UNIT"] = lineComponents[5]
                }
            }
        }
        
        return nameList
    }
     
    func printLines(_ array: [String]) {
        for i in 0 ..< array.count {
            print(array[i])
        }
    }
}

public extension String {
    
    func isNumber() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    
}
