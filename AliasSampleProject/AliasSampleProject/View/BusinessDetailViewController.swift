//
//  BusinessDetailViewController.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit

class BusinessDetailViewController: UIViewController {
    
    //MARK:- IBoutlets
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var bName: UILabel!
    @IBOutlet weak var bNumber: UILabel!
    @IBOutlet weak var bRating: UILabel!
    @IBOutlet weak var bReviews: UILabel!
    @IBOutlet weak var bStatus: UILabel!
    
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
    }

}

//MARK:- Local Methods
extension BusinessDetailViewController {
    
    private func showBusinessDetail() {
        bName.text = business.name
        bNumber.text = business.phone
        bReviews.text = String(business.reviewCount) + " " + "reviews"
        bRating.text = String(business.rating)
        bStatus.text = (business.isClosed == true) ? "Closed" : "Open"
        if business.isClosed == true { bStatus.textColor = UIColor.red }
        businessImageView.sd_setImage(with: URL(string: business.imageUrl), placeholderImage: nil, options: .highPriority, completed: nil)
        businessImageView.roundCorners()
    }
}
