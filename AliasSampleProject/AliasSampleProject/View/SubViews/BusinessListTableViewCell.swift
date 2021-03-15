//
//  BusinessListTableViewCell.swift
//  AliasSampleProject
//
//  Created by ijaz ahmad on 2021-03-14.
//

import UIKit
import SDWebImage

class BusinessListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var business: Business? {
        didSet {
            guard let business = business else { fatalError("business not found") }
            name.text = business.name
            location.text = business.location.address1
            phone.text = business.phone
            rating.text = String(business.rating)
            
            imgView.sd_setImage(with: URL(string: business.imageUrl), placeholderImage: nil, options: .highPriority, completed: nil)
            imgView.roundCorners()
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
