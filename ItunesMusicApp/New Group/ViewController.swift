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

class ViewController: UIViewController, UITableViewDelegate {
    var songs: [Song]?
    var itunesClient = iTunesClient()
    
    func fetchSongs(term: String, entity: String) {
        itunesClient.getSongs(withTerm: term, inEntity: entity) { (songs) in
            self.songs = songs
            print(self.songs!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSongs(term: "Down", entity: "musicTrack")
    }
    
    
    
    

}
    


