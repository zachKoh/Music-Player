//
//  PlayerViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 23/11/2023.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    var musicPlaying: AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(position)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    func configure() {
        // set up player
        let song = songs[position]
        let path = Bundle.main.path(forResource: song.trackName, ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            musicPlaying = try AVAudioPlayer(contentsOf: url)
            musicPlaying?.play()
        } catch {
            print("Error occured loading file...")
        }
        //set up user interface elements
        
    }

}
