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
    
    var artists: [artist] = []
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupStats() {
        let rankedSongs = rankArtistsByPlays()
        let totalPlays = calcTotalPlays()
        
    }
    
    func setupView() {
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
    
    private func rankArtistsByPlays() -> [song] {
        let playedArtists = userDefaults.stringArray(forKey: "PlayedArtists")!
        var rankedArtists = [song]()
        for i in 0..<playedArtists.count {
            rankedArtists.append(song(name: playedArtists[i], plays: userDefaults.integer(forKey: playedArtists[i])))
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
