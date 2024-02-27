//
//  ChartViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 07/02/2024.
//

import UIKit
import SwiftUI
import SnapKit

class ChartViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        let artists = rankArtistsByPlays(artistList: getArtistList(userDefaults: userDefaults))
        let controller = UIHostingController(rootView: SwiftUIChart(artists: artists))
        guard let chartView = controller.view else {
            return
        }
        
        view.addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(500)
        }
    }
    
    //Make a list of songs using the "PlayedSongs" data from user defaults
    func getSongList(userDefaults: UserDefaults) -> [song] {
        guard let PlayedSongs = userDefaults.stringArray(forKey: "PlayedSongs") else {
            return []
        }
        var songList = [song]()
        for i in 0..<PlayedSongs.count {
            songList.append(song(name: PlayedSongs[i], plays: userDefaults.integer(forKey: PlayedSongs[i])))
        }
        return songList
    }
    
    //Get list of played artists with name and play count information
    func getArtistList(userDefaults: UserDefaults) -> [artistObj] {
        guard let playedArtists = userDefaults.stringArray(forKey: "PlayedArtists") else {
            return []
        }
        var artistList = [artistObj]()
        for i in 0..<playedArtists.count {
            artistList.append(artistObj(name: playedArtists[i], plays: userDefaults.integer(forKey: playedArtists[i])))
        }
        return artistList
    }
    
    //Sort the artistList array by plays and create "others" entry if more than 5 artist so that it can fit on chart
    func rankArtistsByPlays(artistList: [artistObj]) -> [artistObj] {
        let sortedArtists = artistList.sorted {
            $0.plays > $1.plays
        }
        return sortedArtists
    }
    
    //For "others" section should it be needed 
    private func calcTotalPlays() -> Int {
        let playedSongs = userDefaults.stringArray(forKey: "PlayedSongs")!
        var totalPlays: Int = 0
        for i in 0..<playedSongs.count {
            totalPlays = totalPlays + userDefaults.integer(forKey: playedSongs[i])
        }
        return totalPlays
    }
}

struct artistObj {
    let name: String
    let plays: Int
}
