//
//  AddSongViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 25/01/2024.
//

import UIKit

class AddSongViewController: UIViewController {

    @IBOutlet weak var songName: UITextField!
    
    @IBOutlet weak var albumName: UITextField!
    
    @IBOutlet weak var artistName: UITextField!
    
    @IBOutlet weak var imageName: UITextField!
    
    @IBOutlet weak var trackName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        let name = songName.text
        let album = albumName.text
        let artist = artistName.text
        let image = imageName.text
        let track = trackName.text
        
        //transfer variables to main view controller
        let viewController = ViewController()
        //viewController.newSongName = "Taylor Swift"
        //viewController.delegate = self
    }
    
}
