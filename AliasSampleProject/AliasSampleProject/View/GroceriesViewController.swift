//
//  GroceriesViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit

class GroceriesViewController: UIViewController {
    
    @IBOutlet weak var groceryTableView: ReuseableBusinessTableview!
    
    //MARK:- Local Verriables
    private var selectedBusiness: Business!
    
    private let businessesListPresenter = BusinessListPresenter(searchString: "Grocery stores")

    override func viewDidLoad() {
        super.viewDidLoad()
        businessesListPresenter.setViewDelegate(businessListViewDelegate: self)
        businessesListPresenter.fetchBusinesses()
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BusinessDetailViewController {
            destinationVC.business = selectedBusiness
        }
    }
}

//MARK:- BusinessListViewDelegate
extension GroceriesViewController: BusinessListViewDelegate {
    
    func displayBusinesses(businesses: [Business]) {
        groceryTableView.setDataSource(businesses: businesses)
        groceryTableView.tableViewRowDidSelectDelegate = self
    }    
}

//MARK:- TableViewRowDidSelectDelegate
extension GroceriesViewController: TableViewRowDidSelectDelegate {
    func rowSelected(model: Business) {
        selectedBusiness = model
        self.performSegue(withIdentifier: "goToDetailViewController", sender: self)
    }
    
    
}
