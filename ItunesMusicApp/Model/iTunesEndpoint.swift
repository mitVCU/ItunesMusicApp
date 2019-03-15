//
//  iTunesSearch.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 2/27/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import Foundation

enum ItunesEndpoint{
    case search(term: String)
    
    var request: URLRequest {
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = querycomponents
        
        let url = components.url!
        return URLRequest(url: url)
    }
    
    private var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    private var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    private struct ParamKey {
        static let country = "country"
        static let term = "term"
        static let entity = "entity"
        static let limit = "limit"
    }
    
    private struct DefaultVal {
        static let country = "us"
        static let entity = "musicTrack"
        static let limit = "50"
    }
    
    var parameters: [String: Any] {
        switch self {
        case .search(let term):
            let parameters: [String : Any] = [
                ParamKey.term : term,
                ParamKey.country : DefaultVal.country,
                ParamKey.entity : DefaultVal.entity,
                ParamKey.limit : DefaultVal.limit
            ]
            return parameters
        }
    }
    
    private var querycomponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        return components
    }
    
}
