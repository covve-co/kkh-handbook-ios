//
//  CalculationsManager.swift
//  Handbook
//
//  Created by Ravern on 9/6/16.
//  Copyright © 2016 SST Inc. All rights reserved.
//

import UIKit
import MessageUI

class CardiacDrugCalculationsManager: NSObject, MFMailComposeViewControllerDelegate {
    
    var weight: Int = -1
    var emailData: String = ""
    
    let firstIndex = 4
    let multipliers = [
        
        
        
        4 : 20,
        5: 50,
        6: 300,
        7: 3,
        8: 10,
        9: 10,
        10: 0.1,
        11: 0.02,
        12: 1,
        13: 0.2,
        14: 50,
        15: 1,
        
        17: 5,
        18: 15,
        19: 0.1,
        20: 0.2,
        
        22: 0.5,
        23: 1,
        24: 4,
        
        26: 0.3,
        27: 3,
        
        29: 30,
        30: 15,
        31: 1,
        32: 3,
        
        34: 15,
        
        36: 50,
        
        
        39: 1,
        
        41: 10,

        43: 3,
        44: 250,
        45: 25
    ]
    var dataLines: [String]!
    
    init(weight: Int) {
        super.init()
        
        self.weight = weight
        
        if let path = Bundle.main.path(forResource: "CardiacDrugList", ofType: "csv") {
            do {
                let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                dataLines = data.components(separatedBy: CharacterSet.newlines)
                for dataLine in dataLines {
                    if dataLine == "" {
                        dataLines.remove(at: dataLines.index(of: dataLine)!)
                    }
                }
                dataLines[1] = dataLines[1].replacingOccurrences(of: "XX", with: "\(weight)")
                for i in 3 ..< dataLines.count {
                    print(dataLines[i])
                    if multipliers[i + 1] != nil {
                        print(dataLines[i])
                        dataLines[i] = dataLines[i].replacingOccurrences(of: "XX", with: truncateIfWhole(Double(weight) * multipliers[i + 1]!))
                    }
                }
                
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
        vc.setSubject("Cardiac Drug Table")
        vc.setMessageBody("Attached is the list of cardiac drugs for patient of \(weight)kg weight.", isHTML: false)
        vc.addAttachmentData(emailData.data(using: String.Encoding.utf8)!, mimeType: "text/csv", fileName: "Cardiac_drug_table.csv")
        
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
        print(dataLines.count)
        for i in firstIndex ..< dataLines.count {
            let dataLine = dataLines[i]
            if !dataLine.hasPrefix(",") {
                let lineComponents = dataLine.components(separatedBy: ",")
                if lineComponents.count > 2 && lineComponents[2].isNumber() {
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

func truncateIfWhole(_ x: Double) -> String {
    if Double(Int(x)) == x {
        return "\(Int(x))"
    }
    return "\(x)"
}
