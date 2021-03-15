//
//  BusinessViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-15.
//

import UIKit
import CoreLocation

class BusinessViewController: UIViewController {
    
    var businessesListPresenter = BusinessListPresenter(searchString: "Resturants")
    
    @IBOutlet weak var businessTableView: ReuseableBusinessTableview!
    
    private var selectedBusinesss: Business!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        businessesListPresenter.setViewDelegate(businessListViewDelegate: self)
        businessTableView.tableViewRowDidSelectDelegate = self
        LocationManager.shared.setDelegate(locationManagerDelegate: self)
        updateUserLocation(status: LocationManager.shared.checkAuthorizationStatus())
        //self.performSegue(withIdentifier: "goToDetailViewController", sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @IBAction func RefreshLocation(_ sender: UIBarButtonItem) {
        businessTableView.setDataSource(businesses: [])
        updateUserLocation(status: LocationManager.shared.checkAuthorizationStatus())
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? BusinessDetailViewController {
            destinationVC.business = selectedBusinesss
        }
    }
    
}

//MARK:- Local Methods
extension BusinessViewController {
    
    @objc func appBecomeActive() {
        LocationManager.shared.setDelegate(locationManagerDelegate: self)
        updateUserLocation(status: LocationManager.shared.checkAuthorizationStatus())
    }
    
    func updateUserLocation(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("not determined")
        case .denied, .restricted:
            Common.showAlert(vc: self, title: "Location Access", message: "We need your current location to show you near by Resturants. Please give us location access from settings")
        default:
            let coordinates = LocationManager.shared.getUserLocation()
            if coordinates != nil {
                businessesListPresenter.fetchBusinesses(latitude: Float(coordinates!.latitude), longitude: Float(coordinates!.longitude))
            }
            else {
                businessesListPresenter.fetchBusinesses(latitude: 40.596309, longitude: -73.977697)
            }
        }
    }
}
extension BusinessViewController: BusinessListViewDelegate {
    func displayBusinesses(businesses: [Business]) {
        businessTableView.setDataSource(businesses: businesses)
    }
    
    
}
extension BusinessViewController: LocationManagerDelegate {
    
    func didUpdateAuthorizationStatus(status: CLAuthorizationStatus) {
        updateUserLocation(status: status)
    }
}

extension BusinessViewController: TableViewRowDidSelectDelegate {
    func rowSelected(model: Business) {
        selectedBusinesss = model
        self.performSegue(withIdentifier: "goToDetailViewController", sender: self)
    }
    
    
}
