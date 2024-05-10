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
        let songName = song.songName ?? " "
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let mp3URL = dir.appendingPathComponent(songName).appendingPathExtension("mp3")
        
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
        let imageURL = dir.appendingPathComponent(songName).appendingPathExtension("JPEG")
        if FileManager.default.fileExists(atPath: imageURL.path) {
            if let theImage = UIImage(contentsOfFile: imageURL.path) {
                // Display the image in the image view
                imageView.image = theImage
            } else {
                // Handle the case where UIImage couldn't be created from the image file
                let theImage: UIImage = UIImage(named: "DefaultAlbumArt")!
                imageView.image = theImage
            }
        } else {
            // Handle the case where the image file doesn't exist at the specified path
            let theImage: UIImage = UIImage(named: "DefaultAlbumArt")!
            imageView.image = theImage
        }
        trackName.text = song.songName
        artistName.text = song.artistName
        
        
        //.................
        // Statistics stuff
        //.................
        
        // Increment the play count for song that is being played in userDefaults
        var playCount = userDefaults.integer(forKey: songName)
        playCount += 1
        userDefaults.set(playCount, forKey: songName)
        
        // Add song name to played songs array if not already there
        var playedSongs = userDefaults.stringArray(forKey: "PlayedSongs")
        // Initialize array if nil
        if(playedSongs == nil) {
            playedSongs = [String]()
        }
        if(playedSongs!.contains(songName)) {
            //Song has already been added
        } else {
            playedSongs?.append(songName)
        }
        userDefaults.set(playedSongs, forKey: "PlayedSongs")
        
        
        // Increment the play count for artist that is being played in userDefaults
        guard let artist: String = song.artistName else {return}
        var artistPlayCount = userDefaults.integer(forKey: artist)
        artistPlayCount += 1
        userDefaults.set(artistPlayCount, forKey: artist)
        
        //Add tartist name to played songs array if not already there
        var playedArtists = userDefaults.stringArray(forKey: "PlayedArtists")
        //Initialize the array if it's nil
        if(playedArtists == nil) {
            playedArtists = [String]()
        }
        if(playedArtists!.contains(artist)) {
            //Song has already been added
            print("Song has already been added")
        } else {
            playedArtists?.append(artist)
        }
        userDefaults.set(playedArtists, forKey: "PlayedArtists")
    }

    @objc func updateSlider(){
        slider.value = Float(musicPlaying?.currentTime ?? 0)
    }
    
    @IBAction func audioChangeTime(_ sender: Any) {
        musicPlaying?.stop()
        musicPlaying?.currentTime = TimeInterval(slider.value)
        musicPlaying?.prepareToPlay()
        musicPlaying?.play()
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
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        if position > 0 {
            position = position - 1
            musicPlaying?.stop()
            configure()
        }
    }
    
    
    @objc func tappedForwardButton(_ sender: Any) {
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        if position < (songs.count - 1) {
            position = position + 1
            musicPlaying?.stop()
            configure()
        }
    }
}
