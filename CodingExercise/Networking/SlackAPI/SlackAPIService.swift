//
//  SlackAPIService.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import Foundation
import Network

enum RequestError: Error {
    case noNetwork
    case invalidJson
    case badRequest
    case badResponse
    case badURL
    case badStatusCode
}

// MARK: - Interfaces

protocol SlackAPIInterface {
    /*
     * Fetches users from search.team API that match the search term
     */
    func fetchUsers(_ searchTerm: String, completionHandler: @escaping ([UserSearchResult]?, RequestError?) -> Void)
}

final class SlackApi: SlackAPIInterface {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    let monitor = NWPathMonitor()
    
    private let baseURLString =  "https://slack-users.herokuapp.com/search"
    
    /**
     A global shared SlackApi Instance.
     */
    static public let shared: SlackApi = SlackApi()
    
    /**
     Fetch Slack users based on a given search term.
     
     - parameter searchTerm: A string to match users against.
     - parameter completionHandler: The closure invoked when fetching is completed and the user search results are given.
     */
    func fetchUsers(_ searchTerm: String, completionHandler: @escaping ([UserSearchResult]?, RequestError?) -> Void) {
        dataTask?.cancel()
        
        self.monitor.pathUpdateHandler = { path in
            if path.status == .unsatisfied {
                completionHandler(nil, .noNetwork)
            }
        }
        
        guard var urlComponents = URLComponents(string: baseURLString) else { return }
        
        let queryItemQuery = URLQueryItem(name: "query", value: searchTerm)
        urlComponents.queryItems = [queryItemQuery]
        
        guard let url = urlComponents.url else {
            completionHandler(nil, .badURL)
            return
        }
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            
            // These will be the results we return with our completion handler
            var resultsToReturn = [UserSearchResult]()
            
            // Ensure that our data task is cleaned up and our completion handler is called
            defer {
                self.dataTask = nil
                completionHandler(resultsToReturn, nil)
            }
            
            if let error = error {
                NSLog("[API] Request failed with error: \(error.localizedDescription)")
                completionHandler(nil, .badRequest)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completionHandler(nil, .badResponse)
                NSLog("[API] Request returned an invalid response")
                return
            }
            
            guard response.statusCode == 200 else {
                completionHandler(nil, .badStatusCode)
                NSLog("[API] Request returned an unsupported status code: \(response.statusCode)")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(SearchResponse.self, from: data)
                resultsToReturn = result.users
            } catch {
                completionHandler(nil, .invalidJson)
                NSLog("[API] Decoding failed with error: \(error)")
            }
        }
        
        dataTask?.resume()
    }
}
