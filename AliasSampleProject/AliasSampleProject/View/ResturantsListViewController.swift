//
//  ResturantsListViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit
import CoreLocation

class ResturantsListViewController: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var businessTableView: ReuseableBusinessTableview!
    
    private let businessesListPresenter = BusinessListPresenter(searchString: "Resturants")
    
    //MARK:- Local Verriables
    private var selectedBusiness: Business!
    
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
        businessTableView.setDataSource(businesses: [])
        updateUserLocation(status: LocationManager.shared.checkAuthorizationStatus())
    }
}

//MARK:- Local Methods
extension ResturantsListViewController {
    
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

extension ResturantsListViewController: LocationManagerDelegate {
    
    func didUpdateLocation(coordinates: CLLocationCoordinate2D) {
        print("ResturantsListViewController location updated")
        businessesListPresenter.fetchBusinesses()
    }
    
    func didUpdateAuthorizationStatus(status: CLAuthorizationStatus) {
        print("ResturantsListViewController authorization status updated")
        updateUserLocation(status: status)
    }
}

