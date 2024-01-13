//
//  NetworkManager.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 6.01.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        // we wanna make sure if we are getting an actual URL
        guard let url = URL(string: endpoint) else {
        // if this doesnt return an valid url, we are just gonna tell view controllers what the error message is and then, they will represent the error with UI we created which is AlerVC
            completed(nil, .invalidUsermane)
            return
        }
        
        // well if we have a good valid URL then,
        let task = URLSession.shared.dataTask(with: url) { data, response, error in     // data is json
            // we are gonna handle these 3 variables in this block
            if let _ = error {  // if error exists, that thing didnt even worked.
                completed(nil, .unableToComplete)
                return
            }
            
            // checks if response is a HTTP response nad also wants to continue if HTTP status code is 200 which means OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)       // handling the bad response.
                return
            }
            
            // making sure the data is not nil
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // we want an array of followers, we gonna try to decode it and the type we have is and array of followers and we want to create that array by data created above.
                let followers = try decoder.decode([Follower].self, from: data)
                // it will decode the json file according to Follower class that we created.
                completed(followers, nil)   // if all goes well
            } catch {
                completed(nil, .invalidData)
            }
        }
        
        task.resume()       // this is what actually starts the network call.
    }
}
