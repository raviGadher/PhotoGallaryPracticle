//
//  GallaryViewController.swift
//  Gallery
//
//  Created by Ravi on 03/02/24.
//

import UIKit
import SwiftPhotoGallery

class GallaryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = GallaryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupViewModel()
        
        self.title = "Images"
        self.navigationItem.hidesBackButton = true
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupViewModel() {
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.fetchImagesURL()
    }
}

extension GallaryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imagesURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let url = viewModel.imagesURL[indexPath.row]
        cell.ImageView.setImage(urlString: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/2
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        gallery.backgroundColor = UIColor.black
        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        gallery.currentPageIndicatorTintColor = UIColor.white
        gallery.hidePageControl = false
        gallery.currentPage = indexPath.row
//        present(gallery, animated: true, completion: nil)
        present(gallery, animated: true, completion: { () -> Void in
            gallery.currentPage = indexPath.row
        })
    }

}
 
class ImageCell : UICollectionViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    
}
