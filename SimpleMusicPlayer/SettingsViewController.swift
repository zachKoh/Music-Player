//
//  SettingsViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 03/02/2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var modeSegment: UISegmentedControl!
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMode()
    }
    
    func updateMode() {
        let playerMode = userDefaults.string(forKey: "playerMode")
        if (playerMode == "normalPlayer") {
            modeSegment.selectedSegmentIndex = 0
        }
        else if (playerMode == "carPlayer"){
            modeSegment.selectedSegmentIndex = 1
        }
        else if (playerMode == "abstractPlayer"){
            modeSegment.selectedSegmentIndex = 2
        }
    }
    
    @IBAction func changedMode(_ sender: Any) {
        switch modeSegment.selectedSegmentIndex {
        case 0:
            userDefaults.set("normalPlayer", forKey: "playerMode")
        case 1:
            userDefaults.set("carPlayer", forKey: "playerMode")
        case 2:
            userDefaults.set("abstractPlayer", forKey: "playerMode")
        default:
            userDefaults.set("normalPlayer", forKey: "playerMode")
        }
    }
}
