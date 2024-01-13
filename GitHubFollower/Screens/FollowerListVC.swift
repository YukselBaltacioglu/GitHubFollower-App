//
//  FollowerListVC.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 5.01.2024.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):       // if it was succesfull, do what you gotta do with followers.
                print(followers)
            case .failure(let error):           // if it fails, present the error.
                self.presentGFAlertOnMainThread(title: "Buff whaa!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    



}
