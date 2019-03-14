//
//  iTunesClient.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 3/9/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import Foundation

struct iTunesClient {
    
    func getSongs(withTerm term: String, completion: @escaping ([Song]?) -> Void ){
        
        let searchEndPoint = ItunesEndpoint.search(term: term)
        let searchUrlRequest = searchEndPoint.request
        
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
                    let songs = try JSONDecoder().decode(SongList.self, from: data)
                    print(songs.results[0])
                    completion(songs.results)
                    
                }catch let error {
                    print("Failed to create json with error: ", error.localizedDescription)
                }
            default:
                print("Error with HTTP Response Code: ", httpResponse.statusCode)
            }
            
        }.resume()
    }
}

