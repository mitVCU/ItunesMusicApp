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
        
        self.albumArt.image = nil
        if let url = URL(string: song.artworkUrl100!){
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse else{
                    print("http rsponse failed")
                    return
                }
                if data == nil {
                    if let error = error {
                        print(error)
                    }
                }
                else{
                    switch httpResponse.statusCode{
                    case 200:
                        DispatchQueue.main.async {
                            if let imageData = data{
                                self.albumArt.image = UIImage(data: imageData)
                            }
                        }
                        
                    default:
                        print("Received HTTP response code: \(httpResponse.statusCode) - was not handled")

                    }
                }
                
            }.resume()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
