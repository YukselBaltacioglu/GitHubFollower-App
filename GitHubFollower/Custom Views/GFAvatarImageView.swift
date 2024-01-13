//
//  GFAvatarImageView.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 13.01.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder")! // since it is gonna be in our assets, we can force and unwrap it.

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true    // in order to corner radius to image into UIImageView
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
