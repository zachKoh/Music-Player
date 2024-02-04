//
//  StatisticsViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 04/02/2024.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var SongNameLabel: UILabel!
    @IBOutlet weak var PlayCountLabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playCount = userDefaults.integer(forKey: "Always")
        SongNameLabel.text = "Always"
        PlayCountLabel.text = String(playCount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let playCount = userDefaults.integer(forKey: "Always")
        SongNameLabel.text = "Always"
        PlayCountLabel.text = String(playCount)
    }
}
