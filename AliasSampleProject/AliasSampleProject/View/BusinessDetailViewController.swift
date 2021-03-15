//
//  BusinessDetailViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit
import Cosmos

class BusinessDetailViewController: UIViewController {
    
    //MARK:- IBoutlets
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var bName: UILabel!
    @IBOutlet weak var bNumber: UILabel!
    @IBOutlet weak var bReviews: UILabel!
    @IBOutlet weak var bStatus: UILabel!
    @IBOutlet weak var callUsBtn: UIButton!
    
    @IBOutlet weak var ratingView: CosmosView!
    
    //MARK:- Inject
    var business: Business!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showBusinessDetail()
        self.title = business.name

        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBActions
    @IBAction func ReservationAction(_ sender: UIButton) {
        if let url = URL(string: business.url) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func Call(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + business.phone) else { return }
        UIApplication.shared.open(number)
    }
}

//MARK:- Local Methods
extension BusinessDetailViewController {
    
    private func showBusinessDetail() {
        bName.text = business.name
        bNumber.text = business.phone
        if business.phone == "" {
            bNumber.text = "Phone number not available"
            callUsBtn.isEnabled = false
            callUsBtn.backgroundColor  = UIColor.lightGray
        }
        bReviews.text = String(business.reviewCount) + " " + "reviews"
        ratingView.rating = business.rating
        bStatus.text = (business.isClosed == true) ? "Closed" : "Open"
        if business.isClosed == true { bStatus.textColor = UIColor.red }
        businessImageView.sd_setImage(with: URL(string: business.imageUrl), placeholderImage: nil, options: .highPriority, completed: nil)
        businessImageView.roundCorners()
    }
}
