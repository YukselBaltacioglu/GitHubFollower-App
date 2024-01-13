//
//  FollowerListVC.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 5.01.2024.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    // collection view will be function in here follower listed page.
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    func configureCollectionView() {            // it will fit in the boundaries of whole view, and we will customize our layout later.
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink                    // since it was static, we can access it
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout() {
        // simple math for sizes
        let width = view?.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)  // since there is also labels.
        
        
        return UICollectionViewFlowLayout()
    }

    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
            case .success(let followers):       // if it was succesfull, do what you gotta do with followers.
                print(followers)
            case .failure(let error):           // if it fails, present the error.
                self.presentGFAlertOnMainThread(title: "Buff whaa!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }


}
