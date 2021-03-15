//
//  GroceriesViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit
import CoreLocation

class GroceriesViewController: UIViewController {
    
    @IBOutlet weak var groceryTableView: ReuseableBusinessTableview!
    
    //MARK:- Local Verriables
    private var selectedBusiness: Business!
    
    private let businessesListPresenter = BusinessListPresenter(searchString: "Grocery stores")

    override func viewDidLoad() {
        super.viewDidLoad()
        businessesListPresenter.setViewDelegate(businessListViewDelegate: self)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LocationManager.shared.setDelegate(locationManagerDelegate: self)
        updateUserLocation(status: LocationManager.shared.checkAuthorizationStatus())
    }
    //remove observers
    override func viewWillDisappear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BusinessDetailViewController {
            destinationVC.business = selectedBusiness
        }
    }
    
    @IBAction func RefreshLocation(_ sender: UIBarButtonItem) {
        groceryTableView.setDataSource(businesses: [])
        updateUserLocation(status: LocationManager.shared.checkAuthorizationStatus())
    }
    
}

//MARK:- Local Methods
extension GroceriesViewController {
    
    @objc func appBecomeActive() {
        LocationManager.shared.setDelegate(locationManagerDelegate: self)
        updateUserLocation(status: LocationManager.shared.checkAuthorizationStatus())
        }
    
    private func updateUserLocation(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("not determined")
        case .denied, .restricted:
            Common.showAlert(vc: self, title: "Location Access", message: "We need your current location to show you near by Resturants. Please give us location access from settings")
        default:
            LocationManager.shared.getUserLocation()
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

extension GroceriesViewController: LocationManagerDelegate {
    func didUpdateLocation(coordinates: CLLocationCoordinate2D) {
        print("GroceriesViewController location updated")
        businessesListPresenter.fetchBusinesses()
    }
    func didUpdateAuthorizationStatus(status: CLAuthorizationStatus) {
        print("GroceriesViewController authorization status updated")
        updateUserLocation(status: status)
    }
}
