//
//  SongCell.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 3/9/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    @IBOutlet weak var albumArt: UIImageView!
    @IBOutlet weak var trackName: UITextField!
    @IBOutlet weak var artistName: UITextField!
    
    var song: Song! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        trackName.text = song.trackName
        artistName.text = song.artistName
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
