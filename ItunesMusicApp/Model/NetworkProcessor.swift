//
//  NetworkProcessor.swift
//  ItunesMusicApp
//
//  Created by Mit Amin on 3/9/19.
//  Copyright © 2019 Mit Amin. All rights reserved.
//

import Foundation

// Input: URLRequest (it has a URL)
// Output: returns JSON, or raw data
// Algo: make a request to some server, download the data, return the data

public let NetworkingErrorDomain = "\(Bundle.main.bundleIdentifier!).NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

// itunes.apple.com/search?term=iron+man&entity=movie

class NetworkProcessor
{
    let request: URLRequest
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    init(request: URLRequest) {
        self.request = request
    }
    
    // IT constructs a URLSession, then download data from the Internet (it takes some time)
    // Returns the data
    // Multi-threading
    
    typealias JSON = [String : Any]
    typealias JSONHandler = (JSON?, HTTPURLResponse?, Error?) -> Void
    typealias DataHandler = (Data?, HTTPURLResponse?, Error?) -> Void
    
    func downloadJSON(_ completion: @escaping JSONHandler){
        session.dataTask(with: self.request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
                _ = NSError(domain: NetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                return
            }
            switch httpResponse.statusCode {
            case 200:
                do {
                    //let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    let json = try JSONDecoder().decode([Song].self, from: data!)
                    print(json, "reached")
                    //completion(json, httpResponse, nil)
                } catch let error as NSError {
                    print("error in Network Processor \(error)")
                }
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift")
            }
        }.resume()
    }
}





















