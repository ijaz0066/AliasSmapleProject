//
//  File.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation

class Location: Decodable {
    
    var city: String
    var country: String
    var address1: String
    var address2: String?
    var address3: String?
    var state: String
    var zipCode: String
    
    enum CodingKeys: String, CodingKey {
        case city, country, address1, address2, address3, state
        case zipCode = "zip_code"
    }
    
    init(city: String, country: String, address1: String, address2: String?, address3: String?, state: String, zipCode: String) {
        
        self.city = city
        self.country = country
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.state = state
        self.zipCode = zipCode
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let city = try container.decode(String.self, forKey: .city)
        let country = try container.decode(String.self, forKey: .country)
        let address1 = try container.decode(String.self, forKey: .address1)
        let address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        let address3 = try container.decodeIfPresent(String.self, forKey: .address3)
        let state = try container.decode(String.self, forKey: .state)
        let zipCode = try container.decode(String.self, forKey: .zipCode)
        

        self.init(city: city, country: country, address1: address1, address2: address2, address3: address3, state: state, zipCode: zipCode)
    }
}
