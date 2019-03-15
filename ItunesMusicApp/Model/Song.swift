//
//  Song.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 2/27/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import Foundation
struct Song: Decodable {
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
    let trackViewUrl: String? // link to song in the actual iTunes store
}
