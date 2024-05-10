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
    
    //Sort the artistList array by plays and create "others" entry if more than 6 artist so that it can fit on chart
    internal func rankArtistsByPlays(artistList: [artistObj]) -> [artistObj] {
        var sortedArtists = artistList.sorted {
            $0.plays > $1.plays
        }
        if sortedArtists.count > 6 {
            let totalPlays = calcTotalPlays()
            sortedArtists.removeSubrange(5...(sortedArtists.count-1))
            var count = 0
            for i in 0...(sortedArtists.count-1){
                count = count + sortedArtists[i].plays
            }
            sortedArtists.append(artistObj(name: "Others", plays: (totalPlays-count)))
        }
        return sortedArtists
    }
    
    //For "others" section should it be needed 
    private func calcTotalPlays() -> Int {
        let playedSongs = userDefaults.stringArray(forKey: "PlayedArtists")!
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
