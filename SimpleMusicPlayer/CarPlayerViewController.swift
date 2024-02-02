//
//  CarPlayerViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 01/02/2024.
//

import AVFoundation
import UIKit

class CarPlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [SongItem] = []
    var musicPlaying: AVAudioPlayer?
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        configure()
        setUpGestures()
    }
    
    func setUpGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTap)
    }
    
    func configure() {
        
        // set up player
        let song = songs[position]
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let mp3URL = dir.appendingPathComponent(song.songName ?? "Love, love, love").appendingPathExtension("mp3")
        //let path = Bundle.main.path(forResource: song.songName, ofType:"mp3")!
        //let url = URL(fileURLWithPath: path)
        
        do {
            musicPlaying = try AVAudioPlayer(contentsOf: mp3URL)
            musicPlaying?.play()
        } catch {
            print("Error occured loading file...")
        }
        
        songNameLabel.text = song.songName
        artistNameLabel.text = song.artistName
        
    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func swipedLeft() {
        if position < (songs.count - 1) {
            position = position + 1
            musicPlaying?.stop()
            configure()
        }
    }
    
    @objc func swipedRight() {
        if position > 0 {
            position = position - 1
            musicPlaying?.stop()
            configure()
        }
    }
    
    @objc func doubleTapped() {
        if !musicPlaying!.isPlaying {
            musicPlaying?.play()
        } else {
            musicPlaying?.pause()
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}
