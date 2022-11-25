//
//  Course.swift
//  getImageFromServer
//
//  Created by Artur on 06.11.2022.
//

import Foundation


struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
