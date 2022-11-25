//
//  WebsiteDescription.swift
//  getImageFromServer
//
//  Created by Artur on 07.11.2022.
//

import Foundation

struct WebsiteDescription: Decodable {
    let websiteDescription: String
    let websiteName: String
    let courses: [Course]
}
