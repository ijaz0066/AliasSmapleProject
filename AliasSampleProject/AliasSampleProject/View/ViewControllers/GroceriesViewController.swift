//
//  GroceriesViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit
import CoreLocation

//we can add any additional steps here for Groceries
class GroceriesViewController: BusinessViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        businessesListPresenter = BusinessListPresenter(searchString: "Grocery Stores")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}
