//
//  BusinessListPresenter.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation

protocol BusinessListViewDelegate: class {
    
    func displayBusinesses(businesses: [Business])
}

class BusinessListPresenter {
    
    weak private var businessListViewDelegate: BusinessListViewDelegate?
    
    private var searchString: String!
    
    init(searchString: String) {
        self.searchString = searchString
    }
    
    func setViewDelegate(businessListViewDelegate: BusinessListViewDelegate?) {
        self.businessListViewDelegate = businessListViewDelegate
    }
    
    func fetchBusinesses(latitude: Float, longitude: Float) {
        BusinessService.shared.fetchBusinesses(searchString: searchString, latitude: latitude, longitude: longitude) { (response) in
            print(response.businesses)
            self.businessListViewDelegate?.displayBusinesses(businesses: response.businesses)
        }
    }
    
}
