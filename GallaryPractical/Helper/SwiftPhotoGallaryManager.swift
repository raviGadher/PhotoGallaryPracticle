//
//  SwiftPhotoGallary.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import Foundation
import SwiftPhotoGallery

extension GallaryViewController : SwiftPhotoGalleryDataSource, SwiftPhotoGalleryDelegate  {
    
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return viewModel.imagesURL.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        var selectedImage : UIImage?
        loadImage(from: URL(string: viewModel.imagesURL[forIndex])!) { image in
            if let image = image {
                selectedImage = image
            } else {
                selectedImage = UIImage(named: "errorImage")
            }
        }
        return selectedImage
    }

    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true, completion: nil)
    }
    
}
