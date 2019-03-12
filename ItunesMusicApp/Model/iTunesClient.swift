//
//  iTunesClient.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 3/9/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import Foundation

struct iTunesClient {
    func getSongs(withTerm term: String, inEntity entity: String, completion: @escaping ([Song]?) -> Void ) {
        let searchEndPoint = ItunesEndpoint.search(term: term, entity: entity)
        let searchUrlRequest = searchEndPoint.request
        print("search url: " , searchUrlRequest)
        
        let networkProcessor = NetworkProcessor(request: searchUrlRequest)
        networkProcessor.downloadJSON { (jsonResponse, httpRespone, error) in
            DispatchQueue.main.async {
                print(jsonResponse!)
//                guard let json = jsonResponse,
//                    let resultDictionaries = json["results"] as? [[String: Any]] else {
//                        completion(nil)
//                        return
//                }
//                let songs = resultDictionaries.compactMap({songDictionary in
//                    return Song(dictionary: songDictionary)
//                })
                
                guard 
                
                completion(songs)
            }
            
        }
        }

}

