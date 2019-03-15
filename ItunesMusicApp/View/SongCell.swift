//
//  SongCell.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 2/27/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    
    var song: Song! {
        didSet {
            self.updateUI()
        }
    }   
    
    func updateUI() {
        trackName.text = song.trackName
        artistName.text = song.artistName
        artistName.layer.masksToBounds = true
        trackName.layer.masksToBounds = true
        artistName.layer.cornerRadius = 5
        trackName.layer.cornerRadius = 5
        
        if let url = URL(string: song.artworkUrl100!){
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                if let data = data {
                    let albumImage = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.albumArt.image = albumImage
                    }
                }
            }
        }
    }
}
