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
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var trackName: UILabel!
    @IBOutlet var artistName: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        //Configuring slider
        slider.maximumValue = Float(musicPlaying?.duration ?? 0)
        //var Timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
        
        //Timer for the slider
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        
        
        //set up user interface elements
        let theImage: UIImage = UIImage(named: song.imageName)!
        imageView.image = theImage
        trackName.text = song.name
        artistName.text = song.artistName
        
    }

    
    @IBAction func audioChangeTime(_ sender: Any) {
        musicPlaying?.stop()
        musicPlaying?.currentTime = TimeInterval(slider.value)
        musicPlaying?.prepareToPlay()
        musicPlaying?.play()
    }
    
    @objc func updateSlider(){
        slider.value = Float(musicPlaying?.currentTime ?? 0)
    }
}
