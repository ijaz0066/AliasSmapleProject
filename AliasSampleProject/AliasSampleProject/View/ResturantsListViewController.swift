//
//  ViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit

class ResturantsListViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var businessTableView: ReuseableBusinessTableview!
    
    private let businessesListPresenter = BusinessListPresenter(searchString: "Resturants")
    
    //MARK:- Local Verriables
    private var selectedBusiness: Business!

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
extension ResturantsListViewController: BusinessListViewDelegate {
    
    func displayBusinesses(businesses: [Business]) {
        
        businessTableView.setDataSource(businesses: businesses)
        businessTableView.tableViewRowDidSelectDelegate = self
    }
}

//MARK:- TableViewRowDidSelectDelegate
extension ResturantsListViewController: TableViewRowDidSelectDelegate {
    func rowSelected(model: Business) {
        print(model)
        selectedBusiness = model
        self.performSegue(withIdentifier: "goToDetailViewController", sender: self)
        
    }
}

