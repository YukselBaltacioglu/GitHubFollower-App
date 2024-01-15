//
//  GFAvatarImageView.swift
//  GithubFollower
//
//  Created by Yüksel Baltacıoğlu on 13.01.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(named: "avatar-placeholder") // since it is gonna be in our assets, we can force and unwrap it.
    let cache            = NetworkManager.shared.cache
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true    // in order to corner radius to image into UIImageView
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    // if anything goes wrong with this network call, we are just gonna return it and show placeholder
    func downloadImage(with urlString: String) {    // since we are not parsing and handling the errors, we did not run this code in network manager
        
        let cacheKey = NSString(string: urlString)  // casting
        if let image = cache.object(forKey: cacheKey) { // once the image is downloaded, set the image to the already downloaded image
            self.image = image
            return  // if we have the cached image, we dont want to do the network calls.
        }
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            // we are intentionally not handling the errors since our placeholder will act as an error.
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            // now we have our data,
            guard let image = UIImage(data: data) else {return}
            
            self.cache.setObject(image, forKey: cacheKey)    // saving the image to the cache
            DispatchQueue.main.async {
                self.image = image
            }
            
            
        }
        
        task.resume()
    }
}
