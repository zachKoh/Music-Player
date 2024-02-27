//
//  StatisticsViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 04/02/2024.
//

import UIKit

class StatisticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let PlayedSongs = userDefaults.stringArray(forKey: "PlayedSongs") else {
            return 0
        }
        return PlayedSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let rankedSongs = rankSongsByPlays(songList: getSongList(userDefaults: userDefaults))
        cell.textLabel?.text = rankedSongs[indexPath.row].name
        cell.detailTextLabel?.text = String(rankedSongs[indexPath.row].plays)
        return cell
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
    
    //Rank the songs and arrange them so that if the no of songs is above 
    func rankSongsByPlays(songList: [song]) -> [song] {
        let sortedSongs = songList.sorted {
            $0.plays > $1.plays
        }
        
        return sortedSongs
    }
}

struct song {
    let name: String
    let plays: Int
}
