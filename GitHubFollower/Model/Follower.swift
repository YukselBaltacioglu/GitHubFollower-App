//
//  Follower.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 6.01.2024.
//

import Foundation
                        // Hashable is neede for differData source
struct Follower: Codable, Hashable {      // Codeable makes it necessary to match the variable names with returning json file's variable names.
    
    var login: String           // we are not gonna make it optional since wea re sure that these are not gonna be nil.
    var avatarUrl: String       // it wa avatar_url but codable can convert snake case into camel case. So its all good.
    
}
