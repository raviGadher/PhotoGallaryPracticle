//
//  ImageViewModel.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import Foundation

class GallaryViewModel {
    
    var imagesURL: [String] = [] {
        didSet {
            self.reloadCollectionView?()
        }
    }

    var reloadCollectionView: (() -> Void)?
    
    func fetchImagesURL() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: [])
               if let jsonDictionary = json as? [String: Any], let images = jsonDictionary["images"] as? [String] {
                   self.imagesURL = images
               }
           } catch {
               print("Error parsing JSON: \(error)")
           }
        } else {
            print("Unable to locate File")
        }
    }
    
    
}

