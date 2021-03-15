//
//  BusinessService.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation
import Alamofire

struct BusinessResponse: Decodable {
    let businesses: [Business]
    
    enum CodingKeys: String, CodingKey {
        case businesses
    }
}

class BusinessService {
    static let shared = BusinessService()
    
    
    let businessRequest = BusinessRequest()
    
    private init() {}
    
    //add functions here to send, update or receive data from rest api
    
    func fetchBusinesses(searchString: String, latitude: Float,  longitude: Float, compilitionHandler: @escaping (_ businesses: BusinessResponse)->Void) {
        
        let request = businessRequest.getRequest(searchString: searchString, latitude: latitude, longitude: longitude)
        request.responseDecodable(of: BusinessResponse.self) { (response) in
            guard let businesses = response.value else { return }
              compilitionHandler(businesses)
        }
    }
    
    //add other functions here to send, update or receive data from rest api
}


