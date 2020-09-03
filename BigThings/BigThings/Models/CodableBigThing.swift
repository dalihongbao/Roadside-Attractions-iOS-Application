//
//  Post.swift
//  BigThings
//
//  Created by Yifeng on 26/11/19.
//  Copyright © 2019 Yifeng. All rights reserved.
//

import Foundation
import SwiftUI

//This is a codable constucter of the Big Thing
struct CodableBigThing: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let location: String
    let year: String
    let status: String
    let latitude: String
    let longitude: String
    let image: String
    let rating: String
    let votes: String
    let updated: String
    let description: String
    
    
    
    init(id: String, name: String, location: String, year: String,  status: String, latitude: String,
         longitude: String,image: String, rating: String,  votes: String, updated: String, description: String) {
        self.id = id
        self.name = name
        self.location = location
        self.year = year
        self.status = status
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.rating = rating
        self.votes = votes
        self.updated = updated
        self.description = description
    }
}
