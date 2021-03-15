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
    
    func getRequest(searchString: String) -> DataRequest {
        
        return AF.request(YelpApiUrl.businessSearch(), method: .get, parameters: ["term":searchString, "location":"New York City"], headers: [authHeader] )
    }
}
