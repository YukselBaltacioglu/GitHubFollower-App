//
//  SearchVC.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 4.01.2024.
//

import UIKit

class SearchVC: UIViewController {
    let logoView = UIImageView()
    let textField = GFTextField()
    let actionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {return !textField.text!.isEmpty}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImageView()
        configureTextField()
        configureActionButton()
        createKeyboardDismissTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    func createKeyboardDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // pushing FollowerListVC to navigation stack when button is tapped.
    // guard statement will have a point in here which basically says: nothing below this line is going to happen
    @objc func pushFollowerListVC() {
        guard isUsernameEntered else {      // if username entered, cool move along,
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We don't know who to look for 😄.", buttonTitle: "Ok")    // else deal with error
            return
        }
        
        let followerListVC = FollowerListVC()
        followerListVC.username = textField.text
        followerListVC.title = textField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureImageView(){
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 200),
            logoView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 48),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureActionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return button tapped")
        return true
    }
}
