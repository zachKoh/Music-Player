//
//  SettingsViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 03/02/2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var onOffSwitch: UISwitch!
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        checkSwitchState()
    }
    
    func checkSwitchState() {
        if(userDefaults.bool(forKey: "onOffKey")) {
            onOffSwitch.setOn(true, animated:false)
        } else {
            onOffSwitch.setOn(false, animated: false)
        }
    }

    @IBAction func carModeSwitch(_ sender: Any) {
        if(onOffSwitch.isOn) {
            userDefaults.set(true, forKey: "onOffKey")
        }
        else {
            userDefaults.set(false, forKey: "onOffKey")
        }
    }
}
