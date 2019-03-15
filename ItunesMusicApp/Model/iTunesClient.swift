//
//  iTunesClient.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 2/27/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import Foundation

struct iTunesClient {
    
    func getSongs(withTerm term: String, completion: @escaping ([Song]?) -> Void ){
        
        let searchEndPoint = ItunesEndpoint.search(term: term)
        let searchUrlRequest = searchEndPoint.request
        var songs = [Song]()
        
        print("search url: " , searchUrlRequest )
        
        URLSession.shared.dataTask(with: searchUrlRequest) { (data, response, error) in
            
            guard let data = data else {
                print("URLSession dataTask error:", error! )
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("http response error: ",error!)
                return
            }
            
            switch httpResponse.statusCode{
            case 200:
                do {
                    let downloadedSongs = try JSONDecoder().decode(SongList.self, from: data)
                    songs = downloadedSongs.results
                    
                    completion(songs)
                    
                }catch let error {
                    print("Failed to decode json with error: ", error.localizedDescription)
                }
            default:
                print("Error with HTTP Response Code: ", httpResponse.statusCode)
            }
            
        }.resume()
    }
}

