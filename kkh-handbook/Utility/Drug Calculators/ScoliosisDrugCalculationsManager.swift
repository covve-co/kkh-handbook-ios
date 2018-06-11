//
//  ScoliosisDrugCalculationsManager.swift
//  Handbook
//
//  Created by Ravern on 26/2/17.
//  Copyright © 2017 SST Inc. All rights reserved.
//

import UIKit
import MessageUI

class ScoliosisDrugCalculationsManager: NSObject, MFMailComposeViewControllerDelegate {
    
    var weight: Int = -1
    var emailData: String = ""
    var dataLines: [String]!
    
    init(weight: Int) {
        super.init()
        
        self.weight = weight
        
        if let path = Bundle.main.path(forResource: "ScoliosisDrugList", ofType: "csv") {
            do {
                let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                dataLines = data.components(separatedBy: ",")
                for i in 0..<dataLines.count {
                    let cell = dataLines[i]
                    var stringToPlayWith = cell.trimmingCharacters(in: CharacterSet.whitespaces)
                    if stringToPlayWith == "ILOVEKKH" {
                        dataLines[i] = "\(weight)"
                    } else if stringToPlayWith.hasSuffix("XX") {
                        stringToPlayWith.characters = stringToPlayWith.characters.dropLast()
                        stringToPlayWith.characters = stringToPlayWith.characters.dropLast()
                        let multiplier = Float(stringToPlayWith)!
                        dataLines[i] = "\(multiplier * Float(weight))"
                    }
                }
//                printLines(dataLines)
                for i in 0 ..< dataLines.count {
                    emailData = emailData + "\(dataLines[i]),"
                }
            } catch {
                
            }
        }
    }
    
    func sendEmail(_ sender: UIViewController) {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = self
        vc.setSubject("Socliosis Drug Table")
        vc.setMessageBody("Attached is the list of scoliosis drugs for patient of \(weight)kg weight.", isHTML: false)
        vc.addAttachmentData(emailData.data(using: String.Encoding.utf8)!, mimeType: "text/csv", fileName: "Scoliosis_drug_table.csv")
        
        sender.present(vc, animated: true) {
            
        }
    }
    
    func printLines(_ array: [String]) {
//        print(array)
        for i in 0 ..< array.count {
            print(array[i], separator: "", terminator: ", ")
        }
    }
    
    func getData() -> Data? {
        return emailData.data(using: String.Encoding.utf8)!
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: {
            
        })
    }
}
