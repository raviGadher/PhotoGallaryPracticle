//
//  KingfisherManager.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(urlString: String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}

    
func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    let imageView = UIImageView()
    imageView.kf.setImage(with: url) { result in
        switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
        }
    }
}

// Fine
