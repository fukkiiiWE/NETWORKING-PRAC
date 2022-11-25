//
//  ViewController.swift
//  getImageFromServer
//
//  Created by Artur on 04.11.2022.
//

import UIKit

class ImageViewController: UIViewController {
    private let url = "https://picsum.photos/300/400"
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIdicator.isHidden = true
        activityIdicator.hidesWhenStopped = true
        fetchImage()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIdicator: UIActivityIndicatorView!
    func fetchImage() {
        activityIdicator.isHidden = false
        activityIdicator.startAnimating()
        NetrworkManager.downloadImage(url: url) { image in
            self.activityIdicator.stopAnimating()
            self.imageView.image = image
        }
    }
}


