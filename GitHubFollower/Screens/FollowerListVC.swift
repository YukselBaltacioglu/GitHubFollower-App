//
//  FollowerListVC.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 5.01.2024.
//

import UIKit

class FollowerListVC: UIViewController {

    enum Section {
        case main
    }
    var username: String!
    var followers: [Follower] = []
    // collection view will be function in here follower listed page.
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground                   // since it was static, we can access it
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    

    func getFollowers() {   // since our newwork manager has strong refenrence to self which is FollowerListVC, this could cause memory leak.
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else {return} // we are basiclly unwarapping the optional self so that we are not gonna need optional sign below.
            
            switch result {
            case .success(let followers):       // if it was succesfull, do what you gotta do with followers.
                print(followers.count)
                self.followers = followers
                self.updateData()
            case .failure(let error):           // if it fails, present the error.
                self.presentGFAlertOnMainThread(title: "Buff whaa!", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {    // what it knows right now, i am gonna be dealing with Follower Object, i know what type of cell Imma gonna use and also how to configure it.
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            // we will create a reusable cell, configure the cell and return the cell
            
            // this one is just regular cell, dont know what kin of cell it is, so we need to cast that into Follower cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            
            // now is time to configure
            cell.set(follower: follower) // this does for every follower, sends that follower information to the FollowerCell and uses set() function, sets the username label to the login name
            
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])    // now we have our sections, we need to add array of followers which is int the newtwork call in getFollower() function.
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }


}
