//
//  ImageProperties.swift
//  getImageFromServer
//
//  Created by Artur on 08.11.2022.
//

import UIKit

struct ImageProperties {
    
    let key: String
    let data: Data
    
    
    init?(wothImage image: UIImage, forKey key:String){
        self.key = key
        guard let data = image.pngData() else {return nil}
        self.data = data
    }
}
