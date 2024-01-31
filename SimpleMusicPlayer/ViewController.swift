//
//  ViewController.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 14/11/2023.
//

import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentPickerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet var table: UITableView!
    
    private var songs = [SongItem]()
    
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.getFiles))
    }
    
    func configureSongs(){
        self.getItems()
        if songs.isEmpty {
            self.createItem(name: "Always", album: "Always", artist: "Daniel Caesar", image: "Image3")
            self.createItem(name: "Just the Way You Are", album: "The Stranger", artist: "Billy Joel", image: "Image2")
            self.createItem(name: "Love, love, love", album: "Extension of a Man", artist: "Donny Hathaway", image: "Image1")
            self.createItem(name: "Always", album: "Always", artist: "Daniel Caesar", image: "Image3")
            self.createItem(name: "Just the Way You Are", album: "The Stranger", artist: "Billy Joel", image: "Image2")
            self.createItem(name: "Love, love, love", album: "Extension of a Man", artist: "Donny Hathaway", image: "Image1")
            self.createItem(name: "Always", album: "Always", artist: "Daniel Caesar", image: "Image3")
            self.createItem(name: "Just the Way You Are", album: "The Stranger", artist: "Billy Joel", image: "Image2")
            self.createItem(name: "Love, love, love", album: "Extension of a Man", artist: "Donny Hathaway", image: "Image1")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        //configure
        cell.textLabel?.text = song.songName
        cell.detailTextLabel?.text = song.artistName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName ?? "Image1")
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
            self.deleteItem(item: songs[indexPath.row])
            self.getItems()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func pressedAddButton(){
        let alert = UIAlertController(
            title: "Add a new song",
            message: "Fill in song details to add a new song.",
            preferredStyle: .alert
        )
        
        //Song name text field
        alert.addTextField { field in
            field.placeholder = "Song name"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        //Album name text field
        alert.addTextField { field in
            field.placeholder = "Album name"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        //Artist name text field
        alert.addTextField { field in
            field.placeholder = "Artist name"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        //Image name text field
        alert.addTextField { field in
            field.placeholder = "Image name"
            field.returnKeyType = .next
            field.keyboardType = .default
        }
        
        //Configure missing field alert
        let missingFieldAlert = UIAlertController(
            title: "Failed to add song",
            message: "Please fill in all fields.",
            preferredStyle: .alert
        )
        missingFieldAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add song", style: .default, handler: { _ in
            
            //read textfield values
            guard let textFields = alert.textFields else {
                return
            }
            let songNameField = textFields[0]
            let albumNameField = textFields[1]
            let artistNameField = textFields[2]
            let imageNameField = textFields[3]
            
            //Check if fields are empty and assign to variables
            guard let songName = songNameField.text, !songName.isEmpty else {
                self.present(missingFieldAlert, animated: true)
                return
            }
            guard let albumName = albumNameField.text, !albumName.isEmpty else {
                self.present(missingFieldAlert, animated: true)
                return
            }
            guard let artistName = artistNameField.text, !artistName.isEmpty else {
                self.present(missingFieldAlert, animated: true)
                return
            }
            guard let imageName = imageNameField.text, !imageName.isEmpty else {
                self.present(missingFieldAlert, animated: true)
                return
            }
            self.createItem(name: songName, album: albumName, artist: artistName, image: imageName)
            self.table.reloadData()
        }))
        
        present(alert, animated: true)
    }
    
    @objc func getFiles(){
        /*let file = "\(UUID().uuidString).txt"
        let contents = "Some text..."
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
        } catch {
            print("error")
        }*/
        
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.audio], asCopy: true)
        pickerViewController.delegate = self
        pickerViewController.allowsMultipleSelection = false
        pickerViewController.shouldShowFileExtensions = true
        self.present(pickerViewController, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("File already exists")
        } else {
            do {
                try FileManager.default.copyItem(at:selectedFileURL, to: sandboxFileURL)
                print("Copied file")
            } catch {
                print("error")
            }
        }
    }
    
    
    func getItems() {
        do {
            songs = try context.fetch(SongItem.fetchRequest())
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        catch {
            //error handling
        }
    }
    
    func createItem(name: String, album: String, artist: String, image: String) {
        let newItem = SongItem(context: context)
        newItem.songName = name
        newItem.albumName = album
        newItem.artistName = artist
        newItem.imageName = image
        
        do {
            try context.save()
            getItems()
        }
        catch {
            //error handling
        }
    }
    
    func deleteItem(item: SongItem) {
        context.delete(item)
        
        do {
            try context.save()
        }
        catch {
            //error handling
        }
    }
    
}
