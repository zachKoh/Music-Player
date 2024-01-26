//
//  ViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 14/11/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
        title = "My Playlist"
        configureBarButtons()
    }
    
    private func configureBarButtons() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.pressedAddButton))
    }
    
    func configureSongs(){
        songs.append(Song(name: "Always", albumName: "Always", artistName: "Daniel Caesar", imageName: "Image3", trackName: "always"))
        songs.append(Song(name: "Just the Way You Are", albumName: "The Stranger", artistName: "Billy Joel", imageName: "Image2", trackName: "Just the Way You Are"))
        songs.append(Song(name: "Love, love, love", albumName: "Extension of a Man", artistName: "Donny Hathaway", imageName: "Image1", trackName: "Love, love, love"))
        songs.append(Song(name: "Always", albumName: "Always", artistName: "Daniel Caesar", imageName: "Image3", trackName: "always"))
        songs.append(Song(name: "Just the Way You Are", albumName: "The Stranger", artistName: "Billy Joel", imageName: "Image2", trackName: "Just the Way You Are"))
        songs.append(Song(name: "Love, love, love", albumName: "Extension of a Man", artistName: "Donny Hathaway", imageName: "Image1", trackName: "Love, love, love"))
        songs.append(Song(name: "Always", albumName: "Always", artistName: "Daniel Caesar", imageName: "Image3", trackName: "always"))
        songs.append(Song(name: "Just the Way You Are", albumName: "The Stranger", artistName: "Billy Joel", imageName: "Image2", trackName: "Just the Way You Are"))
        songs.append(Song(name: "Love, love, love", albumName: "Extension of a Man", artistName: "Donny Hathaway", imageName: "Image1", trackName: "Love, love, love"))
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        //configure
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artistName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //present the player
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            songs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func pressedAddButton(){
        let alert = UIAlertController(
            title: "Add a new song",
            message: "Fill in song details to add a new song.",
            preferredStyle: .alert
        )
        
        alert.addTextField { field in
            field.placeholder = "Song name"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add song", style: .default, handler: { _ in
            //read textfield values
        }))
        
        present(alert, animated: true)
    }

}



struct Song{
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
