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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var songs: [Song]?
    var itunesClient = iTunesClient()
    
    @IBOutlet weak var songTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSongs(term: "Down")
        
    }
    
    func fetchSongs(term: String) {
        itunesClient.getSongs(withTerm: term) { (songs) in
            self.songs = songs
         //   print(self.songs!)
         //   self.songTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs![indexPath.row]
        let songCell = tableView.dequeueReusableCell(withIdentifier: "SongCell") as! SongCell
        songCell.song = song;
        
        return songCell
    }
    
    
    

}
    


