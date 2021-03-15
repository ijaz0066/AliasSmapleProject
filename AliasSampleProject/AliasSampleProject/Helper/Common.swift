//
//  Common.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import Foundation
import UIKit

class Common {
    
    class func registerTableViewCell(nibName: String, identifier: String, tableView: UITableView ) {
        let tableViewCellNib = UINib(nibName: nibName, bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: identifier)
    }
    
    class func showAlert(vc: UIViewController, title: String = "", message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        vc.present(alert, animated: true, completion: nil)
    }
}
