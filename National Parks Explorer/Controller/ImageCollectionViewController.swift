//
//  ImageCollectionViewController.swift
//  National Parks Explorer
//
//  Created by Paul Baker on 4/9/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UICollectionViewController {
    
    
    
    var park: NationalPark?
    let reuseIdentifier = "UICollectionViewCell"
    var photoSet: FlickrPhotoSet?
    let flickrService = FlickrService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        flickrService.searchPhotos(query: park!.fullName) { ( photos: [FlickrPhotoData]?, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                if error != nil {
                    self.present(ErrorAlertController.alert(message: "Unable to fetch photos"), animated: true)
                }
                
                if let photos = photos {
                    if photos.count == 0 {
                        self.present(ErrorAlertController.alert(message: "No photos found, try another park?"), animated: true)
                    }
                    else {
                        print(photos)
                        self.photoSet = FlickrPhotoSet(photos: photos)
                        self.collectionView.reloadData()
                    }
                    
                    
                }
            }
            
        }
        
        
        
    }
    
    

    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        // if already thumbnail set and return
        // if no thumbnail, set placeholder, initiate request.
        // - completion handler will refresh cell once image is downloaded.
        
        guard let photoSet = photoSet else {
            cell.image.image = UIImage(named: "placeholder")
            return cell
        }
        
        if let thumbnail = photoSet.images[indexPath.row].thumbnail {
            cell.image.image = thumbnail
        }
        
        else {
            cell.image.image = UIImage(named: "placeholder")
            requestThumbnail(for: indexPath.row)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSet?.count ?? 0
    }
    
    func requestThumbnail(for index: Int) {
        
        let imageObj = self.photoSet?.images[index]
        
        flickrService.downloadImage(url: imageObj!.thumbnailURL!, completion: { ( thumbnail: UIImage?, error: Error?) in
            self.photoSet?.images[index].thumbnail = thumbnail
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
        })
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoDetail" {
            let selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row
            let selectedImage = photoSet!.images[selectedIndex!]
            let destination = segue.destination as! ImageDetailViewController
            destination.flickrImage = selectedImage
        }
    }

}
    



