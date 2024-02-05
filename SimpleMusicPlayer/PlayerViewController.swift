//
//  PlayerViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 23/11/2023.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    public var position: Int = 0
    public var songs: [SongItem] = []
    var musicPlaying: AVAudioPlayer?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var trackName: UILabel!
    @IBOutlet var artistName: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configure() {
        
        // set up player
        let song = songs[position]
        let songName = song.songName ?? "Love, love, love"
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let mp3URL = dir.appendingPathComponent(songName).appendingPathExtension("mp3")
        //let path = Bundle.main.path(forResource: song.songName, ofType:"mp3")!
        //let url = URL(fileURLWithPath: path)
        
        do {
            musicPlaying = try AVAudioPlayer(contentsOf: mp3URL)
            musicPlaying?.play()
        } catch {
            print("Error occured loading file...")
        }
        
        //Configuring slider
        slider.maximumValue = Float(musicPlaying?.duration ?? 0)
        
        //Timer for the slider
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
        
        
        //set up user interface elements
        let theImage: UIImage = UIImage(named: song.imageName ?? "Image3")!
        imageView.image = theImage
        trackName.text = song.songName
        artistName.text = song.artistName
        
        
        //.................
        // Statistics stuff
        //.................
        
        // Increment the play count for song that is being played in userDefaults
        var playCount = userDefaults.integer(forKey: songName)
        playCount += 1
        userDefaults.set(playCount, forKey: songName)
        
        
        
        // Add song name to song list array if not already there
        var playedSongs = userDefaults.stringArray(forKey: "PlayedSongs")
        
        //playedSongs = [String]()
        
        // Initialize array if nil
        if(playedSongs == nil) {
            playedSongs = [String]()
        }
        if(playedSongs!.contains(songName)) {
            print("That song has been added already")
        } else {
            playedSongs?.append(songName)
        }
        print(playedSongs as Any)
        userDefaults.set(playedSongs, forKey: "PlayedSongs")
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
    
    @IBAction func pressedPause(_ sender: Any) {
        if !musicPlaying!.isPlaying {
            musicPlaying?.play()
            //pauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            musicPlaying?.pause()
            //pauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            musicPlaying?.stop()
        }
    }
    
    
    @objc func tappedBackButton(_ sender: Any) {
        if position > 0 {
            position = position - 1
            musicPlaying?.stop()
            configure()
        }
    }
    
    
    @objc func tappedForwardButton(_ sender: Any) {
        if position < (songs.count - 1) {
            position = position + 1
            musicPlaying?.stop()
            configure()
        }
    }
}
