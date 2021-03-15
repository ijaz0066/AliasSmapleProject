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
    
    func fetchBusinesses(searchString: String, compilitionHandler: @escaping (_ businesses: BusinessResponse)->Void) {
        
        let request = businessRequest.getRequest(searchString: searchString)
        request.responseDecodable(of: BusinessResponse.self) { (response) in
            guard let businesses = response.value else { return }
              compilitionHandler(businesses)
        }
        
    }
}


