//
//  GFButton.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 5.01.2024.
//

import UIKit

class GFButton: UIButton {

    // Initializing the button with a frame, like how big it is.
    // Overriding since GFButton class is a subclass of UIButton main class.
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // for other buttons to avoid repeating
    init(backgroundColor: UIColor, title: String){
        // call the overrided methode above
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
