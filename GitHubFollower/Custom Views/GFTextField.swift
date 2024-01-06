//
//  GFTextField.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 5.01.2024.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 2
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        font = .preferredFont(forTextStyle: .title2)
        minimumFontSize = 12
        
        returnKeyType = .go
        placeholder = "Enter Username"
        autocorrectionType = .no
        backgroundColor =  .tertiarySystemBackground
    }

}
