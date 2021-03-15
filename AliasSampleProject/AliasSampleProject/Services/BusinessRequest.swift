//
//  BusinessRequest.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation
import Alamofire

struct BusinessRequest {
    
    let authHeader = HTTPHeader(name: "Authorization", value: "Bearer" + " " + YelpApiUrl.apiKey)
    
    init() {}
    //make requests here
    func getRequest(searchString: String, latitude: Float, longitude: Float) -> DataRequest {
        
        return AF.request(YelpApiUrl.businessSearch(), method: .get, parameters: ["term":searchString, "latitude":latitude, "longitude": longitude], headers: [authHeader] )
    }
    
    
}
