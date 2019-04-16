//
//  ImageDetailViewController.swift
//  National Parks Explorer
//
//  Created by Paul Baker on 4/9/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var flickrImage: FlickrImage?
    var flickrService = FlickrService()
    
    @IBOutlet var photoDetails: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoData = flickrImage!.photoData
        photoDetails.text = photoData!.title
        let url = flickrImage!.fullURL
        
        flickrService.downloadImage(url: url!) { (image: UIImage?, error: Error?) -> Void in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    self.present(ErrorAlertController.alert(message: "Error fetching photo"), animated: true)
                }
                else {
                    self.imageView.image = image
                }
            }
        }
    }
}
