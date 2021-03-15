//
//  ReuseableBusinessTableview.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit

protocol TableViewRowDidSelectDelegate {
    
    func rowSelected(model: Business)
}

class ReuseableBusinessTableview: UITableView {

    
    let identifier = "cell"
    var businesses: [Business] = []
    
    var tableViewRowDidSelectDelegate: TableViewRowDidSelectDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Common.registerTableViewCell(nibName: "BusinessListTableViewCell", identifier: identifier, tableView: self)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    func setDataSource(businesses: [Business]) {
        dataSource = self
        delegate = self
        self.businesses = businesses
        self.reloadData()
    }
}

extension ReuseableBusinessTableview: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BusinessListTableViewCell
        cell!.business = businesses[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewRowDidSelectDelegate?.rowSelected(model: businesses[indexPath.row])
    }
    
    
}
