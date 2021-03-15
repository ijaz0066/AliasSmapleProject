//
//  Business.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation

class Business: Decodable {
    
    var id: String
    var name: String
    var rating: Double
    var reviewCount: Int
    var url: String
    var location: Location
    var phone: String
    var imageUrl: String
    var isClosed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, rating, phone, url, location
        case reviewCount = "review_count"
        case imageUrl = "image_url"
        case isClosed = "is_closed"
    }
    
    init(id: String, name: String, rating: Double, reviewCount: Int, url: String, location: Location, phone: String, imageUrl: String, isClosed: Bool) {
        
        self.id = id
        self.name = name
        self.rating = rating
        self.reviewCount = reviewCount
        self.url = url
        self.location = location
        self.phone = phone
        self.imageUrl = imageUrl
        self.isClosed = isClosed
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let rating = try container.decode(Double.self, forKey: .rating)
        let reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        let url = try container.decode(String.self, forKey: .url)
        let location = try container.decode(Location.self, forKey: .location)
        let phone = try container.decode(String.self, forKey: .phone)
        let imageUrl = try container.decode(String.self, forKey: .imageUrl)
        let isClosed = try container.decode(Bool.self, forKey: .isClosed)
        

        self.init(id: id, name: name, rating: rating, reviewCount: reviewCount, url: url, location: location, phone: phone, imageUrl: imageUrl, isClosed: isClosed)
    }
}
