//
//  ViewController.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 2/21/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import UIKit

// take user input, perform network requests, and display information to the user.

//search term, and show track name, artist name, and album art for each result.

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var songs: [Song]? //array of song objects that will hold the songs returned from itunes api
    var itunesClient = iTunesClient() //service that will retrieve api
    
    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("pressed search")
        searchField.resignFirstResponder()  // hides keyboard when user presses search button
        fetchSongs()  // retrieves songs using the text from the search field
        return true
    }
    
    func fetchSongs() {
        
        guard let searchQuery = searchField.text else { //safely upack the optional string from search field
            print("invalid")
            return
        }
            itunesClient.getSongs(withTerm: searchQuery) { (songs) in  //enters the getSongs() method to query itunes api
                self.songs = songs  // begins after the completion of the getSongs() method from the itunes client
                DispatchQueue.main.async { // moving to main thread to perform UI changes
                    self.songTableView.restore()  // moves table view off of the empty view and is ready to be populated with Song Cells
                    self.songTableView.reloadData()  // refresh the ui to show the new songs
                    if(searchQuery.isEmpty){
                        self.songTableView.setEmptyView(title: "No Songs", message: "Search For Some Songs")
                    }
                }
            }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let songCount = songs?.count else {
            songTableView.setEmptyView(title: "No Songs", message: "Search For Some Songs")
            return 0
        }
        print(songCount)
        return songCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs![indexPath.row]
        let songCell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        songCell.song = song;
        
        return songCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let urlStringToStore = songs?[indexPath.row].trackViewUrl else {
            print("Song does not have an itunes url")
            return
        }
        guard let urlToStore = URL(string: urlStringToStore) else {
            print("URL provided was not a valid URL")
            return
        }
        
        print(urlStringToStore, "url to itunes store")
        
        UIApplication.shared.open(urlToStore)
    }
    
}
