//
//  ErrorMessage.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 13.01.2024.
//

import Foundation
// this way, it is way better to change them as we go.
enum GFError: String, Error { // its raw value is string.
    case invalidUsermane = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from server is invalid. Please try again."
}
