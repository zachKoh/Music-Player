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
        setupStats()
        setupView()
    }
    
    func setupStats() {
        let rankedArtists = rankArtistsByPlays()
        //For "others" section
        let totalPlays = calcTotalPlays()
        print(rankedArtists)
        print(totalPlays)
    }
    
    func setupView() {
        let artists = rankArtistsByPlays()
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
    
    private func rankArtistsByPlays() -> [artistObj] {
        let playedArtists = userDefaults.stringArray(forKey: "PlayedArtists")!
        var rankedArtists = [artistObj]()
        for i in 0..<playedArtists.count {
            rankedArtists.append(artistObj(name: playedArtists[i], plays: userDefaults.integer(forKey: playedArtists[i])))
        }
        let sortedArtists = rankedArtists.sorted {
            $0.plays > $1.plays
        }
        return sortedArtists
    }
    
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
