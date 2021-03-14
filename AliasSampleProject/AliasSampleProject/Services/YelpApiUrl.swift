//
//  YelpApiUrl.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation

enum EndPoint: String {
    //add api end points here
    case businessSearch = "search"
}

class YelpApiUrl {
    static private let baseUrl = "https://api.yelp.com/v3/businesses/"
}

extension YelpApiUrl {
    
    //Functions to get api endpoints
    static func businessSearch() -> URL {
        let url = URL(string: baseUrl + EndPoint.businessSearch.rawValue)!
        return url
    }

}

